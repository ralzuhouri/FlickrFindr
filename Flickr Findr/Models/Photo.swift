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
    
    static var mock: Photo {
        return Photo(id: "52689697392",
                     secret: "0399bcdc4c",
                     server: "65535",
                     title: "Miniature painter on ladder and Happy Easter text")
    }
}

extension Photo: Hashable, Equatable, Identifiable {
}
