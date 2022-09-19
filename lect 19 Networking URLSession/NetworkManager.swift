//
//  NetworkManager.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 19.09.2022.
//

import Foundation

class NetworkManager {
    
    
    func getAllPosts(_ complitionHandler: @escaping ([Post]) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            URLSession.shared.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print("error in request")
                } else {
                    if let responce = responce as? HTTPURLResponse,
                       responce.statusCode == 200,
                       let responceData = data {
                        let posts = try? JSONDecoder().decode([Post].self, from: responceData)
                        complitionHandler(posts ?? [])
                    }
                }
            }.resume()
        }
    }
}
