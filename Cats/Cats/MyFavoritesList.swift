//
//  MyFavoritesList.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct MyFavoritesList: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        NavigationView {
            List {
                // Each cat struct has its own unique 'id' used by ForEach
                ForEach(userData.catsList) { aCat in
                    NavigationLink(destination: MyFavoriteDetails(cat: aCat)) {
                        MyFavoriteItem(cat: aCat)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
            .navigationBarTitle(Text("Cats I Like"), displayMode: .inline)
           
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
           
        }   // End of NavigationView
    }
   
    /*
     -------------------------------
     MARK: - Delete Selected cat
     -------------------------------
     */
    /*
     IndexSet:  A collection of unique integer values that represent the indexes of elements in another collection.
     first:     The first integer in self, or nil if self is empty.
     */
    func delete(at offsets: IndexSet) {
        if let first = offsets.first {
            userData.catsList.remove(at: first)
        }
        // Set the global variable point to the changed list
        catStructList = userData.catsList
    }
   
    /*
     -----------------------------
     MARK: - Move Selected cat
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
 
        userData.catsList.move(fromOffsets: source, toOffset: destination)
       
        // Set the global variable point to the changed list
        catStructList = userData.catsList
    }
}
 
 
struct MyFavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoritesList()
            .environmentObject(UserData())
    }
}
 
 
