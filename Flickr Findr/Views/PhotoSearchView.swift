//
//  PhotoSearchView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

struct PhotoSearchView: View {
    @StateObject var viewModel: PhotoSearchViewModel
    
    init(photoService: PhotoServiceProtocol) {
        _viewModel = StateObject(wrappedValue: PhotoSearchViewModel(photoService: photoService))
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhotoSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSearchView(photoService: PhotoServiceMock())
    }
}
