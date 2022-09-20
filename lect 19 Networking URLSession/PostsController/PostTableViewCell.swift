//
//  PostTableViewCell.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 20.09.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTitleBody: UILabel!
    
     func configure(_ post: Post) {
         postTitleLabel.text = post.title
         postTitleBody.text = post.body
    }
    
}
