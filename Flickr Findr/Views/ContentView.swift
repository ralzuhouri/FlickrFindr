//
//  ContentView.swift
//  Flickr Findr
//
//  Created by Ramy Al Zuhouri on 15/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationState = NavigationState()
    
    var body: some View {
        NavigationStack(path: $navigationState.selectedPhotos) {
            PhotoSearchView(photoService: PhotoService())
                .environmentObject(navigationState)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
