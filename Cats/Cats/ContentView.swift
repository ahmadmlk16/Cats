//
//  ContentView.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView {
            CatPhoto()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Cat Photo")
                }
            MyFavoritesList()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Cats I Like")
                }
            SearchCatBreed()
                .tabItem {
                    Image(systemName: "circle.grid.hex")
                    Text("Cat Breed")
                }
        }   // End of TabView
        .font(.headline)
        .imageScale(.medium)
        .font(Font.title.weight(.regular))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
