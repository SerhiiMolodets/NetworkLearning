//
//  NetworkManager.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 19.09.2022.
//

import Foundation

class NetworkManager {
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    enum APIs: String {
        case posts
        case users
        case comments
    }
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    func getAllPosts(_ complitionHandler: @escaping ([Post]) -> Void) {
        if let url = URL(string: baseURL + APIs.posts.rawValue) {
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
    
    func postCreatePost(_ post: Post,  complitionHandler: @escaping (Post) -> Void) {
        let sendData = try? JSONEncoder().encode(post)
        guard let url = URL(string: baseURL + APIs.posts.rawValue),
              let data = sendData else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            if error != nil {
                print("error")
            } else if let resp = responce as? HTTPURLResponse,
                      resp.statusCode == 201, let responceData = data {
                if let responcePost = try? JSONDecoder().decode(Post.self, from: responceData) {
                    complitionHandler(responcePost)
                }
                
            }
        }.resume()
    }
    
    func getPostBy(userId: Int, complitionHandler: @escaping (([Post]) -> Void)) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [ URLQueryItem(name: "userID", value: "\(userId)")]
        
        guard let queryURL = components?.url else { return }
        
        URLSession.shared.dataTask(with: queryURL) { (data, responce, error) in
            if error != nil {
                print("error getPostBy")
            } else if let resp = responce as? HTTPURLResponse,
                      resp.statusCode == 200,
                      let receiveData = data {
                let posts = try? JSONDecoder().decode([Post].self, from: receiveData)
                complitionHandler(posts ?? [])
            }
        }
    }
}
