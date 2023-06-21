//
//  NetworkService.swift
//  Networking
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import Foundation

public class NetworkService {
    public var cats: [CatDTO] = []
    
    public func getCats(url link: String, onCompletion: @escaping (NetworkService) -> Void) {        
        let urlSession = URLSession(configuration: .default)
        guard let url = URL(string: link) else { return }
        
        let _ = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, let dataList = try? JSONDecoder().decode([CatDTO].self, from: data) else { return }
            
            self.cats.append(contentsOf: dataList)
            onCompletion(self)
        }.resume()
    }
    
    public init() {}
}
