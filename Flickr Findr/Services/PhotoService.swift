//
//  PhotoService.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import Foundation
import Alamofire

// MARK: - Private Types and Properties
class PhotoService {
    private enum PhotoServiceError: Error {
        case originalSizeNotFound
        case originalSizeUrlNotFound
    }
    
    private var apiKey: String {
        return "1508443e49213ff84d566777dc211f2a"
    }
    
    private var baseUrl: URL {
        guard let url = URL(string: "https://api.flickr.com/services/rest") else {
            fatalError("Could not find photo base URL")
        }
        
        return url
    }
    
    private var photoBaseUrl: URL {
        guard let url = URL(string: "https://live.staticflickr.com") else {
            fatalError("Could not find photo base URL")
        }
        
        return url
    }
}

// MARK: - PhotoServiceProtocol
extension PhotoService: PhotoServiceProtocol {
    func searchPhotos(text: String, limit: Int) async throws -> [PhotoProtocol] {
        struct Response: Codable {
            struct Photos: Codable {
                var photo: [Photo]
            }
            
            var photos: Photos
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let parameters: [String: Any] = [
                "method": "flickr.photos.search",
                "api_key": apiKey,
                "format": "json",
                "text": text,
                "privacy_filter": 1,
                "nojsoncallback": 1
            ]
            
            AF.request(baseUrl, method: .get, parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(Response.self, from: data)
                            let limit = min(limit, response.photos.photo.count)
                            let photos = Array(response.photos.photo[0..<limit])
                            continuation.resume(returning: photos)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func fetchPhotoThumbnailData(_ photo: PhotoProtocol) async throws -> Data {
        let url = photoBaseUrl
            .appending(path: photo.server)
            .appending(path: "\(photo.id)_\(photo.secret)_t.jpg")
        
        return try Data(contentsOf: url)
    }
    
    func fetchOriginalPhotoData(_ photo: PhotoProtocol) async throws -> Data {
        let originalSize = try await fetchOriginalPhotoSize(photo)
        
        guard let url = URL(string: originalSize.source) else {
            throw PhotoServiceError.originalSizeUrlNotFound
        }
        
        return try Data(contentsOf: url)
    }
}

// MARK: - Private Functions
extension PhotoService {
    private func fetchOriginalPhotoSize(_ photo: PhotoProtocol) async throws -> PhotoSize {
        struct Response: Codable {
            struct Sizes: Codable {
                var size: [PhotoSize]
            }
            
            var sizes: Sizes
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let parameters: [String: Any] = [
                "method": "flickr.photos.getSizes",
                "api_key": apiKey,
                "format": "json",
                "photo_id": photo.id,
                "nojsoncallback": 1
            ]
            
            AF.request(baseUrl, method: .get, parameters: parameters)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(Response.self, from: data)
                            
                            let originalSize = response.sizes.size.first { photoSize in
                                return photoSize.label == "Original"
                            }
                            
                            guard let originalSize = originalSize else {
                                throw PhotoServiceError.originalSizeNotFound
                            }
                            
                            continuation.resume(returning: originalSize)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
