//
//  CatBreedResult.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
import MapKit
 
struct CatBreedResult: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData

    @State private var showAddedMessage = false
   
    var body: some View {
  
       Form {
                Section(header: Text("Cat Breed Identification Code")) {
                    Text(verbatim: catbreed)
                }
                Section(header: Text("catFound Breed Name")) {
                    Text(verbatim: catFound.name)
                }
                Section(header: Text("Cat Photo")) {
                    getImageFromUrl(url: catFound.url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
                Section(header: Text("Cat Breed Description")) {
                    Text(verbatim: catFound.description)
                }
                Section(header: Text("Add this cat to my favorites list")) {
                                    Button(action: {
                                        // Append the country found to userData.countriesList
                                        
                                        self.userData.catsList.append(catFound)
                 
                                        // Set the global variable point to the changed list
                                        catStructList = self.userData.catsList
                                       
                                        self.showAddedMessage = true
                                    }) {
                                        Image(systemName: "plus")
                                            .imageScale(.medium)
                                            .font(Font.title.weight(.regular))
                                    }
                 }
                       
                Section(header: Text("Cat Breed Temperament")) {
                    Text(verbatim: catFound.temperament)
                }
                Section(header: Text("Cat Breed Origin")) {
                    Text(verbatim: catFound.origin)
                }
                Section(header: Text("Cat Breed Life Span in Years")) {
                    Text(verbatim: catFound.life_span)
                }
                Section(header: Text("Cat Breed Weight in Pounds")) {
                    Text(verbatim: catFound.weight)
                }
                Section(header: Text("More Info at Vetstreet.com")) {
                    NavigationLink(destination: WebView(url: catFound.vetstreet_url)
                    .frame(width: UIScreen.main.bounds.width)){
                        HStack{
                            Image(systemName: "globe")
                            .resizable()
                                .frame(width: 25.0, height: 25.0)
                                .scaledToFill()
                            Text("See more info on " + catFound.name)
                        }
                    }
                }
                
                
        }//end of form
        .alert(isPresented: $showAddedMessage, content: { self.alert })

    }
   // generates alert notification
    var alert: Alert {
        Alert(title: Text("Cat Breed Added!"),
              message: Text("Cat breed " + catFound.name + " is added to your Cats I Like list"),
              dismissButton: .default(Text("OK")) )
    }
    
    var alert2: Alert {
        Alert(title: Text("Cat Breed Not Added!"),
              message: Text("Cat breed " + catFound.name + " is already to your Cats I Like list"),
              dismissButton: .default(Text("OK")) )
    }
   
}
 
 
struct CatBreedResult_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedResult()
    }
}
 
 
