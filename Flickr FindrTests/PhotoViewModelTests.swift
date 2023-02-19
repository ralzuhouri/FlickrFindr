//
//  PhotoThumbnailViewModelTests.swift
//  Flickr FindrTests
//
//  Created by Ramy Al Zuhouri on 17/02/2023.
//

import XCTest
@testable import Flickr_Findr

final class PhotoViewModelTests: XCTestCase {
    let thumbnailSize = CGSize(width: 150, height: 150)
    let originalSize = CGSize(width: 4968, height: 2551)
    
    func testFetchMockThumbnailPhoto() async throws {
        let sut = PhotoViewModel(photoService: PhotoServiceMock(), photo: Photo.mock)
        let photo = try await sut.fetchThumbnail()
        XCTAssertEqual(photo.size, thumbnailSize)
    }
    
    func testFetchThumbnailPhotoFromApi() async throws {
        let sut = PhotoViewModel(photoService: PhotoService(), photo: Photo.mock)
        let photo = try await sut.fetchThumbnail()
        XCTAssertEqual(photo.size, thumbnailSize)
    }
    
    func testFetchMockOriginalPhoto() async throws {
        let sut = PhotoViewModel(photoService: PhotoServiceMock(), photo: Photo.mock)
        let photo = try await sut.fetchOriginal()
        XCTAssertEqual(photo.size, originalSize)
    }
    
    func testFetchOriginalPhotoFromApi() async throws {
        let sut = PhotoViewModel(photoService: PhotoService(), photo: Photo.mock)
        let photo = try await sut.fetchOriginal()
        XCTAssertEqual(photo.size, originalSize)
    }
}
