//
//  PhotoSearchView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

struct PhotoSearchView: View {
    @EnvironmentObject var navigationState: NavigationState
    @StateObject private var viewModel: PhotoSearchViewModel
    @State private var searchTerm: String = ""
    
    private let photoService: PhotoServiceProtocol
    
    init(photoService: PhotoServiceProtocol) {
        _viewModel = StateObject(wrappedValue: PhotoSearchViewModel(photoService: photoService))
        self.photoService = photoService
    }
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .notStarted:
                Text("Start a Search by Typing in the Above Text Field")
            case .loading:
                ProgressView()
            case .loaded(let photos):
                LazyVStack {
                    ForEach(photos, id: \.id) { photo in
                        PhotoThumbnailView(photoService: photoService, photo: photo)
                            .onTapGesture {
                                guard let photo = photo as? Photo else {
                                    assertionFailure("Could not downcast to Photo")
                                    return
                                }
                                
                                navigationState.selectedPhotos = [ photo ]
                            }
                    }
                }
            case .error(let error):
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
        .searchable(text: $searchTerm, prompt: "Search Photos")
        .navigationDestination(for: Photo.self) { photo in
            PhotoOriginalView(photoService: photoService, photo: photo)
        }
        .onChange(of: searchTerm) { _ in
            Task {
                try await viewModel.searchPhotos(searchTerm: searchTerm)
            }
        }
    }
}

struct PhotoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSearchView(photoService: PhotoServiceMock())
    }
}
