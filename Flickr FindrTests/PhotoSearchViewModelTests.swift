//
//  PhotoSearchViewModelTests.swift
//  Flickr FindrTests
//
//  Created by Ramy Al Zuhouri on 16/02/2023.
//

import XCTest
@testable import Flickr_Findr

final class PhotoSearchViewModelTests: XCTestCase {
    func testLoadMockPhotos() async throws {
        let sut = PhotoSearchViewModel(photoService: PhotoServiceMock())
        let photos = try await sut.searchPhotos(searchTerm: "rome")
        XCTAssertEqual(photos.count, 100)
    }
    
    func testLoadPhotosFromApi() async throws {
        let sut = PhotoSearchViewModel(photoService: PhotoService())
        let photos = try await sut.searchPhotos(searchTerm: "rome")
        XCTAssertEqual(photos.count, 100)
    }
}
