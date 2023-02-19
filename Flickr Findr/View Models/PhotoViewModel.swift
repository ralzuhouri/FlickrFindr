//
//  PhotoThumbnailViewModel.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

class PhotoViewModel: ObservableObject {
    enum State {
        case loading, loaded(UIImage), error(Error)
    }
    
    private enum FetchError: Error {
        case failedToDecodeData
    }
    
    @Published var state: State = .loading
    
    private let photoService: PhotoServiceProtocol
    private let photo: PhotoProtocol
    
    init(photoService: PhotoServiceProtocol, photo: PhotoProtocol) {
        self.photoService = photoService
        self.photo = photo
    }
    
    @MainActor @discardableResult
    func fetchThumbnail() async throws -> UIImage {
        do {
            let data = try await photoService.fetchPhotoThumbnailData(photo)
            
            
            guard let image = UIImage(data: data) else {
                throw FetchError.failedToDecodeData
            }
            
            state = .loaded(image)
            return image
        } catch {
            state = .error(error)
            throw error
        }
    }
    
    @MainActor @discardableResult
    func fetchOriginal() async throws -> UIImage {
        do {
            let data = try await photoService.fetchOriginalPhotoData(photo)
            
            guard let image = UIImage(data: data) else {
                throw FetchError.failedToDecodeData
            }
            
            state = .loaded(image)
            return image
        } catch {
            state = .error(error)
            throw error
        }
    }
}
