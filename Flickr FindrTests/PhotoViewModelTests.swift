//
//  PhotoThumbnailViewModelTests.swift
//  Flickr FindrTests
//
//  Created by Ramy Al Zuhouri on 17/02/2023.
//

import XCTest
@testable import Flickr_Findr

final class PhotoViewModelTests: XCTestCase {
    let thumbnailSize = 100.0
    let originalSize = CGSize(width: 6720, height: 4200)
    
    func testFetchMockThumbnailPhoto() async throws {
        let sut = PhotoViewModel(photoService: PhotoServiceMock(), photo: Photo.mock)
        let photo = try await sut.fetchThumbnail()
        XCTAssertEqual(max(photo.size.width, photo.size.height), thumbnailSize)
    }
    
    func testFetchThumbnailPhotoFromApi() async throws {
        let sut = PhotoViewModel(photoService: PhotoService(), photo: Photo.mock)
        let photo = try await sut.fetchThumbnail()
        XCTAssertEqual(max(photo.size.width, photo.size.height), thumbnailSize)
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
