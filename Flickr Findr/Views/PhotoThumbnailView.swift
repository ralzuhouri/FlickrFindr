//
//  PhotoThumbnailView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import SwiftUI

struct PhotoThumbnailView: View {
    let photo: PhotoProtocol
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhotoThumbnailView_Previews: PreviewProvider {
    static let photo = Photo.mock
    
    static var previews: some View {
        PhotoThumbnailView(photo: photo)
    }
}
