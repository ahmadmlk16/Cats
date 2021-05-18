//
//  SearchCatBreed.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI

import SwiftUI
 
struct SearchCatBreed: View {
   
//choices for cats
    let searchCategories = ["Abyssinian (abys)", "Aegean (aege)", "American Bobtail (abob)", "American Curl (acur)", "American Shorthair (asho)", "American Wirehair (awir)", "Arabian Mau (amau)", "Australian Mist (amis)", "Balinese (bali)", "Bambino (bamb)", "Bengal (beng)", "Birman (birm)", "Bombay (bomb)", "British Longhair (bslo)", "British Shorthair (bsho)", "Burmese (bure)", "Burmilla (buri)", "California Spangled (cspa)", "Chantilly-Tiffany (ctif)", "Chartreux (char)", "Chausie (chau)", "Cheetoh (chee)", "Colorpoint Shorthair (csho)", "Cornish Rex (crex)", "Cymric (cymr)", "Cyprus (cypr)", "Devon Rex (drex)", "Donskoy (dons)", "Dragon Li (lihu)", "Egyptian Mau (emau)", "European Burmese (ebur)", "Exotic Shorthair (esho)", "Havana Brown (hbro)", "Himalayan (hima)", "Japanese Bobtail (jbob)", "Javanese (java)", "Khao Manee (khao)", "Korat (kora)", "Kurilian (kuri)", "LaPerm (lape)", "Maine Coon (mcoo)", "Malayan (mala)", "Manx (manx)", "Munchkin (munc)", "Nebelung (nebe)", "Norwegian Forest Cat (norw)", "Ocicat (ocic)", "Oriental (orie)", "Persian (pers)", "Pixie-bob (pixi)", "Ragamuffin (raga)", "Ragdoll (ragd)", "Russian Blue (rblu)", "Savannah (sava)", "Scottish Fold (sfol)", "Selkirk Rex (srex)", "Siamese (siam)", "Siberian (sibe)", "Singapura (sing)", "Snowshoe (snow)", "Somali (soma)", "Sphynx (sphy)", "Tonkinese (tonk)", "Toyger (toyg)", "Turkish Angora (tang)", "Turkish Van (tvan)", "York Chocolate (ycho)"]
    @State var selectedSearchCategory = 0
   
    var body: some View {
       
        NavigationView {
            Form {
                Section(header: Text("Select Search Category")) {
                    Picker("Pick", selection: $selectedSearchCategory) {
                        ForEach(0 ..< searchCategories.count, id: \.self) {
                            Text(self.searchCategories[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
               
  
                    Section(header: Text("Generate")) {
                        NavigationLink(destination: searchCatBreed) {
                            HStack {
                                Image(systemName: "gear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Get Cat Breed Details")
                            }
                        }
                    }
                
            }   // End of Form

        }   // End of NavigationView
    }
   
    var searchCatBreed: some View {
       // seperates the code from the search catagories
        var breed = searchCategories[selectedSearchCategory]
        var sub = breed.suffix(5)
        sub = sub.prefix(4)
        breed = String(sub)
        
        // public function obtainCountryDataFromApi is given in CountryApiData.swift
        obtainCatDataFromApi(breed: breed, request: "cat")
 
        return AnyView(CatBreedResult())
    }
}
 
 
struct SearchCatBread_Previews: PreviewProvider {
    static var previews: some View {
        SearchCatBreed()
    }
}
