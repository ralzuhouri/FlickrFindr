//
//  PhotoThumbnailView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

struct PhotoThumbnailView: View {
    private enum State {
        case loading, loaded, error(Error)
    }
    
    @StateObject var viewModel: PhotoViewModel
    private let photo: PhotoProtocol
    
    init(photoService: PhotoServiceProtocol, photo: PhotoProtocol) {
        _viewModel = StateObject(wrappedValue: PhotoViewModel(photoService: photoService, photo: photo))
        self.photo = photo
    }
    
    var body: some View {
        HStack {
            Text(photo.title)
            
            Spacer()
            
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let image):
                Image(uiImage: image)
            case .error(let error):
                Text(error.localizedDescription)
                    .foregroundColor(.red)
            }
        }
        .frame(height: 150)
        .onAppear {
            Task {
                try await viewModel.fetchThumbnail()
            }
        }
    }
}

struct PhotoThumbnailView_Previews: PreviewProvider {
    static let photo: PhotoProtocol = Photo.mock
    static let photoService: PhotoServiceProtocol = PhotoServiceMock()
    
    static var previews: some View {
        PhotoThumbnailView(photoService: photoService, photo: photo)
    }
}
