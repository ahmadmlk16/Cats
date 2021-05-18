//
//  CatApiData.swift
//  Cats
//
//  Created by cs3714 on 2/26/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI








// Declare catFound as a global mutable variable accessible in all Swift files
var catFound = Cat(id: "", name: "", vetstreet_url: "", temperament: "", origin: "", description: "", life_span: "", weight: "", url: "")

// variables to reference globally the two input fields of the main function
var catbreed = ""
var reqType = ""

/*
 ====================================
 MARK: - Obtain Cat Data from API
 ====================================
 */
public func obtainCatDataFromApi(breed: String, request: String) {
   
    
    // goes to line 23-24
    catbreed = breed
    reqType = request

    
    
    // Initialization
    catFound = Cat(id: "", name: "", vetstreet_url: "", temperament: "", origin: "", description: "", life_span: "", weight: "", url: "")
    
    //initialize URL
    var apiUrl = ""
    
    
    //switch between The CatPhot View and CatBreedResult View
    switch request{
    case "cat":
        apiUrl="https://api.thecatapi.com/v1/images/search?breed_id=\(breed)"
    case "image":
        apiUrl="https://api.thecatapi.com/v1/images/search"
    default:
        fatalError("request is out of range")
    }
    
    
    /*
     searchQuery may include unrecognizable foreign characters inputted by the user,
     e.g., Côte d'Ivoire, that can prevent the creation of a URL struct from the
     given apiUrl string. Therefore, we must test it as an Optional.
     */
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        // countryFound will have the initial values set as above
        return
    }
    
    /*
     *******************************
     *   HTTP GET Request Set Up   *
     *******************************
     */
    
    let headers = [
        "x-api-key": "226d7318-7b3c-4dc9-a04e-56e51559720b",
        "accept": "application/json",
        "cache-control": "no-cache",
        "host": "api.thecatapi.com"
    ]
    
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    /*
     *********************************************************************
     *  Setting Up a URL Session to Fetch the JSON File from the API     *
     *  in an Asynchronous Manner and Processing the Received JSON File  *
     *********************************************************************
     */
    
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
         URLSession is established and the JSON file from the API is set to be fetched
         in an asynchronous manner. After the file is fetched, data, response, error
         are returned as the input parameter values of this Completion Handler Closure.
         */
        
        // Process input parameter 'error'
        guard error == nil else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
        
        /*
         ---------------------------------------------------------
         🔴 Any 'return' used within the completionHandler Closure
         exits the Closure; not the public function it is in.
         ---------------------------------------------------------
         */
        
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
        
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
        
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
            
            
            
            var id = "", name = "", vetstreet_url = "", temperament = "", origin = ""
            var description = "", life_span = "", weight = "",  url = ""
            
            
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            var catDataDictionary = Dictionary<String, Any>()   // Or [String: Any]()
            
            
            /*
             https://restcountries.eu/rest/v2/name/germany?fullText=true
             https://restcountries.eu/rest/v2/capital/berlin
             Returns an Array of one JSON object [{jsonObject}]
             */
            if let jsonArray = jsonResponse as? [Any] {
                if let jsonObject = jsonArray.first as? [String: Any] {
                    catDataDictionary = jsonObject
                    
                } else {
                    // countryFound will have the initial values set as above
                    semaphore.signal()
                    
                    return
                }
            } else {
                // countryFound will have the initial values set as above
                semaphore.signal()
                
                return
            }
            
    
            
            // This only runs if we are generating the CatBreedResult view
            if (reqType.isEqual("cat"))
            {
                // parses the nested jsons
                var breedsJsonArray = [Any]()
                if let jArray = catDataDictionary["breeds"] as? [Any] {
                    breedsJsonArray = jArray
                } else {
                    semaphore.signal()
                    return
                }
                
                //-------------------------
                // Obtain Foods JSON Object
                //-------------------------
                
                
                //convert array into object
                var breedsJsonObject = [String: Any]()
                if let jObject = breedsJsonArray[0] as? [String: Any] {
                    breedsJsonObject = jObject
                } else {
                    semaphore.signal()
                    return
                }
                
                
                
                
                
                // feed values from json into global foundCat
                if let nameOfCat = breedsJsonObject["name"] as? String{
                    name = nameOfCat
                } else {
                    name = "unavailable"
                }
                  // feed values from json into global foundCat
                if let vUrl = breedsJsonObject["vetstreet_url"] as? String {
                    vetstreet_url = vUrl
                } else {
                    vetstreet_url = "unavailable"
                }
                  // feed values from json into global foundCat
                if let temp = breedsJsonObject["temperament"] as? String{
                    temperament = temp
                }else {
                    temperament = "unavailable"
                }
                  // feed values from json into global foundCat
                if let orig = breedsJsonObject["origin"] as? String{
                    origin = orig
                }else {
                    origin = "unavailable"
                }
                  // feed values from json into global foundCat
                if let desc = breedsJsonObject["description"] as? String{
                    description = desc
                }else {
                    description = "unavailable"
                }
                  // feed values from json into global foundCat
                if let life = breedsJsonObject["life_span"] as? String{
                    life_span = life
                }else {
                    life_span = "unavailable"
                }
                
                
                
                
                
            
                
            // parse the nested json with weights
                var weightsJsonObject = [String: Any]()
                if let iObject = breedsJsonObject["weight"] as? [String: Any] {
                    weightsJsonObject = iObject
                } else {
                    semaphore.signal()
                    return
                }
                
                  // feed values from json into global foundCat
                if let weig = weightsJsonObject["imperial"] as? String{
                    weight = weig
                }else {
                    weight = "unavailable"
                }
                
            }
            
            
            
              // feed values from json into global foundCat
            if let iUrl = catDataDictionary["url"] as? String {
                url = iUrl
            } else {
                url = "unavailable"
            }
            
            
            
            
            
            
            
            //----------------------------------------------------------
            // Construct a New Cat Struct and Set it to catFound
            //----------------------------------------------------------
            
            catFound = Cat(id: id, name: name, vetstreet_url: vetstreet_url, temperament: temperament, origin: origin, description: description, life_span: life_span, weight: weight, url: url)
            
            
            
            
            
            
            
        } catch {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
     
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
     */
    
    _ = semaphore.wait(timeout: .now() + 10)
    
}

