//
//  PhotoService.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import Foundation
import Alamofire

class PhotoService: PhotoServiceProtocol {
    private struct Response: Codable {
        fileprivate struct Photos: Codable {
            var photo: [Photo]
        }
        
        var photos: Photos
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
    
    func searchPhotos(text: String) async throws -> [PhotoProtocol] {
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
                            
                            let json = String(data: data, encoding: .utf8)
                            print(json)
                            
                            let response = try decoder.decode(Response.self, from: data)
                            continuation.resume(returning: response.photos.photo)
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
