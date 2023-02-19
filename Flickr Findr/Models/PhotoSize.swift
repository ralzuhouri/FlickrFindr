//
//  PhotoSize.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 17/02/2023.
//

import Foundation

class PhotoSize: Codable {
    var label: String
    var width: Int
    var height: Int
    var source: String
    var url: String
    var media: String
    
    init(label: String,
         width: Int,
         height: Int,
         source: String,
         url: String,
         media: String) {
        self.label = label
        self.width = width
        self.height = height
        self.source = source
        self.url = url
        self.media = media
    }
}
