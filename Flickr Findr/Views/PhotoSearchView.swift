//
//  PhotoSearchView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

struct PhotoSearchView: View {
    @StateObject private var viewModel: PhotoSearchViewModel
    @State private var searchTerm: String = ""
    @State private var isShowingDetail: Bool = false
    @State private var selectedPhoto: PhotoProtocol?
    
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
                                isShowingDetail = true
                                selectedPhoto = photo
                            }
                    }
                }
            case .error(let error):
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
        .fullScreenCover(isPresented: $isShowingDetail) { [selectedPhoto] in
            PhotoOriginalView(photoService: photoService, photo: selectedPhoto!)
        }
        .searchable(text: $searchTerm, prompt: "Search Photos")
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
