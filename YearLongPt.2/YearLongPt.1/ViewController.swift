//
//  ViewController.swift
//  YearLongPt.1
//
//  Created by Everett Brothers on 9/19/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var recentLabel: UILabel!
    @IBOutlet weak var postView: UIView!
    var dark = false
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postimg: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    var post: Post!
    var chk = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SettingsViewController {
            vc.darkMode = dark
        }
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: nil)
    }
    
    @IBAction func unwindToUser(segue: UIStoryboardSegue) {
        updateUI()
    }
    
    func updateUI() {
        if dark {
            self.view.backgroundColor = .black
            titleLabel.textColor = .white
            tabBarController?.tabBar.unselectedItemTintColor = .lightGray
            postView.backgroundColor = .black
            recentLabel.textColor = .white
            postLabel.textColor = .white
            desLabel.textColor = .white
            nameLabel.textColor = .white
        } else {
            self.view.backgroundColor = .white
            titleLabel.textColor = .black
            tabBarController?.tabBar.unselectedItemTintColor = .darkGray
            postView.backgroundColor = .white
            recentLabel.textColor = .black
            postLabel.textColor = .black
            desLabel.textColor = .black
            nameLabel.textColor = .black
        }
        if let postTab = tabBarController?.viewControllers?[1] as? PostsViewController {
            postTab.postDark = dark
        }
        if chk == false {
            postView.isHidden = true
            recentLabel.text = "No Posts"
            chk = true
        }
        if post != nil {
            postimg.image = post.image
            postLabel.text = post.text
            recentLabel.text = "Recent Post:"
            postView.isHidden = false
        }
    }
    
}

