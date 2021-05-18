//
//  MyFavoriteItem.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct MyFavoriteItem: View {
    // Input Parameter
    let cat: Cat
   
    var body: some View {
        HStack {
            //gets cat image
            getImageFromUrl(url: cat.url)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 80.0)
            
            VStack(alignment: .leading){
                Text(cat.name)
                Text("id:  " + cat.id)
                Text("Life Span:  " + cat.life_span + " years")
                Text("Weight:  " + cat.weight + " lbs")
            }//End of Vstack
            .font(.subheadline)
        }   // End of HSTACK
    }
}
 
 
struct MyFavoriteItem_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoriteItem(cat: catStructList[0])
    }
}
