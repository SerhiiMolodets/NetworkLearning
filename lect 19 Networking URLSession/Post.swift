//
//  Post.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 19.09.2022.
//

import Foundation

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
