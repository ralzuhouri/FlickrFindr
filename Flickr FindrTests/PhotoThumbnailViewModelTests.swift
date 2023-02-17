//
//  PhotoThumbnailViewModelTests.swift
//  Flickr FindrTests
//
//  Created by Ramy Al Zuhouri on 17/02/2023.
//

import XCTest
@testable import Flickr_Findr

final class PhotoThumbnailViewModelTests: XCTestCase {
    let thumbnailSize = CGSize(width: 150, height: 150)
    
    func testFetchMockThumbnailPhoto() async throws {
        let sut = PhotoThumbnailViewModel(photoService: PhotoServiceMock(), photo: Photo.mock)
        let photo = try await sut.fetchThumbnail()
        XCTAssertEqual(photo.size, thumbnailSize)
    }
    
    func testFetchThumbnailPhotoFromApi() async throws {
        let sut = PhotoThumbnailViewModel(photoService: PhotoService(), photo: Photo.mock)
        let photo = try await sut.fetchThumbnail()
        XCTAssertEqual(photo.size, thumbnailSize)
    }
}
