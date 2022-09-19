//
//  ViewController.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func downloadPostsDidTap(_ sender: Any) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            URLSession.shared.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print("error in request")
                } else {
                    if let responce = responce as? HTTPURLResponse,
                       responce.statusCode == 200,
                       let responceData = data {
                        let posts = try? JSONDecoder().decode([Post].self, from: responceData)
                        DispatchQueue.main.async {
                            self.titleLabel.text = "Posts have been downloaded"
                        }

                        print(posts)
                    }
                    
                }
                
                
                
            }.resume()
        }
        
    }
}

