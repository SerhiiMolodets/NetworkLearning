//
//  ViewController.swift
//  lect 19 Networking URLSession
//
//  Created by Сергей Молодец on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PostCellID")
        }
    }
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        networkManager.getAllPosts {[weak self] (posts) in
        //            DispatchQueue.main.async {
        //                self?.posts = posts
        //            }
        //        }
        
        
        networkManager.getPostBy(userId: 3) { [weak self] (posts) in
            DispatchQueue.main.async {
                self?.posts = posts
            }
        }
    }
    
    @IBAction func createPost(_ sender: Any) {
        var post = Post(userId: 1, id: 0, title: "somePost", body: "mybody")
        networkManager.postCreatePost(post) { serverPost in
            post.id = serverPost.id
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: "Your post has been created", preferredStyle: .alert)
                self.present(alert, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    alert.dismiss(animated: true)
                }
                
            }
            
        }
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID", for: indexPath) as! PostTableViewCell
        cell.configure(posts[indexPath.row])
        
        return cell
    }
    
    
}
