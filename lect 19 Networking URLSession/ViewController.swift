//
//  ViewController.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    var networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func downloadPostsDidTap(_ sender: Any) {
        networkManager.getAllPosts { [weak self] posts in
            DispatchQueue.main.async {
                self?.titleLabel.text = "Posts has been downloaded"
            }
        }
        
    }
}

