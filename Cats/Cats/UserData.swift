//
//  UserData.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Combine
import SwiftUI
 
final class UserData: ObservableObject {


    // Publish catsList with initial value of catsStructList obtained in CatData.swift
    @Published var catsList = catStructList

}
 
