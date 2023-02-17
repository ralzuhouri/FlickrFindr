//
//  PhotoSearchViewModel.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

class PhotoSearchViewModel: ObservableObject {
    enum State {
        case notStarted, loading, loaded([PhotoProtocol]), error(Error)
    }
    
    @Published var state: State = .notStarted
    
    private let photoService: PhotoServiceProtocol
    
    init(photoService: PhotoServiceProtocol) {
        self.photoService = photoService
    }
    
    @MainActor @discardableResult
    func searchPhotos(searchTerm: String) async throws -> [PhotoProtocol] {
        guard searchTerm != "" else {
            state = .notStarted
            return []
        }
        
        do {
            state = .loading
            let photos = try await photoService.searchPhotos(text: searchTerm)
            state = .loaded(photos)
            return photos
        } catch {
            state = .error(error)
            throw error
        }
    }
}
