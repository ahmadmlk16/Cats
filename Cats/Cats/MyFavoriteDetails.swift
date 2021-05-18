//
//  MyFavoriteDetails.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
import MapKit
 
struct MyFavoriteDetails: View {
    // Input Parameter
    let cat: Cat
   
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            
            Section(header: Text("Cat Breed Identification Code")) {
                Text(verbatim: cat.id)
            }
            Section(header: Text("Cat Breed Name")) {
                Text(verbatim: cat.name)
            }
            Section(header: Text("Cat Photo")) {
                getImageFromUrl(url: cat.url)
                .resizable()
                .aspectRatio(contentMode: .fit)
            }
            Section(header: Text("Cat Breed Description")) {
                Text(verbatim: cat.description)
            }
            Section(header: Text("Cat Breed Temperament")) {
                Text(verbatim: cat.temperament)
            }
            Section(header: Text("Cat Breed Origin")) {
                Text(verbatim: cat.origin)
            }
            Section(header: Text("Cat Breed Life Span in Years")) {
                Text(verbatim: cat.life_span)
            }
            Section(header: Text("Cat Breed Weight in Pounds")) {
                Text(verbatim: cat.weight)
            }
            
            // link cats website
            Section(header: Text("More Info at Vetstreet.com")) {
                NavigationLink(destination: WebView(url: cat.vetstreet_url)
                .frame(width: UIScreen.main.bounds.width)){
                    HStack{
                        Image(systemName: "globe")
                        .resizable()
                            .frame(width: 25.0, height: 25.0)
                            .scaledToFill()
                        Text("See more info on " + cat.name)
                    }
                }
            }
            
            
    }//end of form
        .font(.subheadline)
         .navigationBarTitle(Text("Cat Breed Details"), displayMode: .inline)
}
 
 
struct MyFavoriteDetails_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteDetails(cat: catStructList[0])
    }
}
}
