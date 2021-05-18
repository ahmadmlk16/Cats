//
//  Cat.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
//  Cat Struct 
struct Cat: Hashable, Codable, Identifiable{
    
   var id: String
   var name: String
   var vetstreet_url: String
   var temperament: String
   var origin: String
   var description: String
   var life_span: String
   var weight: String
   var url: String

}
