//
//  PhotoMetadata.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import Foundation

struct Photo: PhotoProtocol, Codable {
    var id: String
    var secret: String
    var server: String
    var title: String
}
