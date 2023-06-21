//
//  CatStorage.swift
//  Networking
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import Foundation
import Networking
import FirebasePerformance

enum Const {
    static let API_CONFIG = "API request value"
    
    static let CAT_URL = "https://api.thecatapi.com/v1/images/search?limit=20&api_key=live_9gpwFK5l0hdcXDfAhLE96h49F0MK0xDtcdVWbo9AzCtAvyi4577clDu8N2CBSPFd"
    static let DOG_URL = "https://api.thedogapi.com/v1/images/search?limit=20&api_key=live_9gpwFK5l0hdcXDfAhLE96h49F0MK0xDtcdVWbo9AzCtAvyi4577clDu8N2CBSPFd"
    
    static let CAT_NAMES: [String] = [
        "Fluffy", "Max", "Bella", "Charlie", "Lucy",
        "Milo", "Bailey", "Daisy", "Oliver", "Toby",
        "Luna", "Rocky", "Roxy", "Jack", "Sadie", "Zeus",
        "Riley", "Molly", "Coco", "Sasha", "Shadow",
        "Teddy", "Ziggy", "Buddy", "Lucky", "Chloe",
        "Simba", "Jasper", "Gizmo", "Maximus", "Sammy",
        "Oscar", "Finn", "Bentley", "Rusty", "Harley",
        "Leo", "Snickers", "Winston", "Ruby", "Koda",
        "Maggie", "Ginger", "Kiki", "Cinnamon", "Rufus",
        "Lily", "Casper", "Mittens", "Pepper"
    ]
}

class CatStorage: ObservableObject {
    @Published var catsList: [CatDTO] = []
    let storage = NetworkService()
    init() {
        let listTrace = Performance.startTrace(name: "CatListLoad")
        let url = isCatApiUsed() ? Const.CAT_URL: Const.DOG_URL
        storage.getCats(url: url) { [weak self] arrayOfCats in
            DispatchQueue.main.async {
                self?.catsList = arrayOfCats.cats
            }
        }
        listTrace?.stop()
    }
    
    func isCatApiUsed() -> Bool {
        guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let plistData = NSDictionary(contentsOfFile: plistPath),
              let config = plistData[Const.API_CONFIG] as? String
        else {
            fatalError("\(Const.API_CONFIG) is missing")
        }
        return config.lowercased() == "cats"
    }
    
    func getRandomName() -> String {
        Const.CAT_NAMES.randomElement() ?? "Nameless \(isCatApiUsed() ? "cat": "dog")"
    }
}

