//
//  CatPhoto.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI




struct CatPhoto: View {
    //state variable to update the image once the url changes
    @State var url = catFound.url
    @EnvironmentObject var userData: UserData
    

    var body: some View {
        NavigationView{
        ZStack(){
            VStack{
                
                //gens image
             getImageFromUrl(url: url)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 10)
                
                
                //button which calls function and updates image
                Button(action: genNewImage){
                    Text("Show Another Random Cat Photo")
                }
                
                
                
                Text ("Powered By:")
                    .padding(.top, 28.0)
                Image("TheCatApiLogo")
                .resizable()
                .frame(width: 120, height: 80)
                
                //Link to the APIS website
                NavigationLink(destination: WebView(url: "https://www.thecatapi.com/")
                     .navigationBarTitle("The Cat API")
                                   .frame(width: UIScreen.main.bounds.width)){
                                           Text("The Cat API")
                                   
                                   }
                
            }
    
        }
    }
        
    }
    //function to get new json from api and update the state variable url
    func genNewImage()  {
        obtainCatDataFromApi(breed: "", request: "image")
        url = catFound.url
    }
}




struct CatPhoto_Previews: PreviewProvider {
    static var previews: some View {
        CatPhoto()
    }
}
