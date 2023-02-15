//
//  PhotoMetadataProtocol.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import Foundation

protocol PhotoProtocol {
    var id: String { get }
    var secret: String { get }
    var server: String { get }
    var title: String { get }
}
