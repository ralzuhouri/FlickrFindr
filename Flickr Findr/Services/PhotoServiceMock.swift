//
//  PhotoServiceMock.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import Foundation
import UIKit

class PhotoServiceMock: PhotoServiceProtocol {
    enum Error: LocalizedError {
        case fileNotFound, encodingError
    }
    
    func searchPhotos(text: String) async throws -> [PhotoProtocol] {
        guard let photosJsonUrl = Bundle.main.url(forResource: "Photos", withExtension: "json") else {
            assertionFailure("Cannot fine Photos.json")
            throw Error.fileNotFound
        }
        
        let jsonData = try Data(contentsOf: photosJsonUrl)
        let decoder = JSONDecoder()
        let photos = try decoder.decode([Photo].self, from: jsonData)
        return photos
    }
    
    func fetchPhotoData(_ photo: PhotoProtocol) async throws -> Data {
        let image = UIImage(named: "Thumbnail")
        
        guard let data = image?.jpegData(compressionQuality: 1.0) else {
            throw Error.encodingError
        }
        
        return data
    }
}
