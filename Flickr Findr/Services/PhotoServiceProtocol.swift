//
//  PhotoServiceProtocol.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import Foundation

protocol PhotoServiceProtocol {
    func searchPhotos(text: String, limit: Int) async throws -> [PhotoProtocol]
    func fetchPhotoThumbnailData(_ photo: PhotoProtocol) async throws -> Data
    func fetchOriginalPhotoData(_ photo: PhotoProtocol) async throws -> Data
}
