//
//  PhotoOriginalView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 19/02/2023.
//

import SwiftUI

struct PhotoOriginalView: View {
    private enum State {
        case loading, loaded, error(Error)
    }
    
    @StateObject private var viewModel: PhotoViewModel
    private let photo: PhotoProtocol
    
    init(photoService: PhotoServiceProtocol, photo: PhotoProtocol) {
        _viewModel = StateObject(wrappedValue: PhotoViewModel(photoService: photoService, photo: photo))
        self.photo = photo
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(photo.title)
                
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded(let image):
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                case .error(let error):
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchOriginal()
            }
        }
    }
}

struct PhotoOriginalView_Previews: PreviewProvider {
    static let photo: PhotoProtocol = Photo.mock
    static let photoService: PhotoServiceProtocol = PhotoServiceMock()
    
    static var previews: some View {
        PhotoOriginalView(photoService: photoService, photo: photo)
    }
}
