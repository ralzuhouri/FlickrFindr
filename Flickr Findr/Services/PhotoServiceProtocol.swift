//
//  PhotoServiceProtocol.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import Foundation

protocol PhotoServiceProtocol {
    func searchPhotos(text: String) async throws -> [PhotoProtocol]
    func fetchPhotoData(_ photo: PhotoProtocol) async throws -> Data
}
