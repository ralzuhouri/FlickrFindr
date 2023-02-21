//
//  NavigationState.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 21/02/2023.
//

import SwiftUI

class NavigationState: ObservableObject {
    @Published var selectedPhotos: [Photo] = []
}
