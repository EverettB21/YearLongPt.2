//
//  PostsViewController.swift
//  YearLongPt.1
//
//  Created by Everett Brothers on 9/20/23.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class PostsViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var numPosts = 0
    var postDark = false
    var posts: [Post] = []
    var post: Post = Post(image: nil, text: "")
    var i = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
    }
    
    func submit(image: UIImage?, text: String) {
        posts.insert(Post(image: image, text: text), at: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let vc = tabBarController?.viewControllers?[0] as? ViewController {
            if posts.count > 0 {
                vc.post = posts[0]
            }
        }
    }
    
    @objc func addPost() {
        let ac = UIAlertController(title: "Add Post", message: nil, preferredStyle: .alert)
        
        let button = UIAlertAction(title: "Choose File", style: .default) { [weak self, weak ac] _ in
            self?.submit(image: nil, text: ac?.textFields?[0].text ?? "Post")
            let ip = UIImagePickerController()
            ip.delegate = self
            ip.sourceType = .photoLibrary
            self?.present(ip, animated: true, completion: nil)
        }
        
        ac.addTextField() {text in
            text.placeholder = "Add message"
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(button)
        present(ac, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if post.image != nil {
                posts[i].image = selectedImage
            } else {
                posts[0].image = selectedImage
            }
            picker.dismiss(animated: true, completion: nil)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        if postDark {
            self.tableView.backgroundColor = .black
            tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        } else {
            self.tableView.backgroundColor = .white
            tabBarController?.tabBar.unselectedItemTintColor = .darkGray
        }
    }
    
    func editPost(_ tableView: UITableView, indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let ac = UIAlertController(title: "Edit Post", message: nil, preferredStyle: .alert)
        
        let button = UIAlertAction(title: "Choose File", style: .default) { [weak self, weak ac] _ in
            self?.submitEdit(image: nil, text: ac?.textFields?[0].text ?? "Post")
            let ip = UIImagePickerController()
            ip.delegate = self
            ip.sourceType = .photoLibrary
            self?.present(ip, animated: true, completion: nil)
        }
        
        let done = UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] _ in
            self?.submitEdit(image: post.image, text: ac?.textFields?[0].text ?? "Post")
        }
        
        ac.addTextField() {text in
            text.text = post.text
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(button)
        ac.addAction(done)
        present(ac, animated: true)
    }
    
    func submitEdit(image: UIImage?, text: String) {
        posts[i] = Post(image: image, text: text)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        post = posts[indexPath.row]
        i = indexPath.row
        editPost(tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label = cell.viewWithTag(2) as? UILabel
        let imageView = cell.viewWithTag(1) as? UIImageView
        
        let post = posts[indexPath.row]
        
        if postDark {
            label?.textColor = .white
            cell.contentView.backgroundColor = .black
        } else {
            label?.textColor = .label
            cell.contentView.backgroundColor = .white
        }
        
        imageView?.image = post.image
        label?.text = post.text
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
