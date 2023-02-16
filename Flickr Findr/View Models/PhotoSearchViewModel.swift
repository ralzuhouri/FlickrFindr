//
//  PhotoSearchViewModel.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

class PhotoSearchViewModel: ObservableObject {
    enum State {
        case notStarted, loading, loaded, error(Error)
    }
    
    @Published var state: State = .notStarted
    @Published var photos: [PhotoProtocol] = []
    
    private var photoService: PhotoServiceProtocol
    
    init(photoService: PhotoServiceProtocol) {
        self.photoService = photoService
    }
    
    @MainActor @discardableResult
    func searchPhotos(searchTerm: String) async throws -> [PhotoProtocol] {
        do {
            state = .loading
            photos = try await photoService.searchPhotos(text: searchTerm)
            state = .loaded
            return photos
        } catch {
            state = .error(error)
            throw error
        }
    }
}
