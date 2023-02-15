//
//  PhotoServiceTests.swift
//  Flickr FindrTests
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import XCTest
@testable import Flickr_Findr

final class PhotoServiceTests: XCTestCase {
    let sut = PhotoService()

    func testSearchPhotos() async throws {
        let photos = try await sut.searchPhotos(text: "rome")
        XCTAssertEqual(photos.count, 100)
    }
}
