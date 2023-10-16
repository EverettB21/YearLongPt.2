//
//  SettingsViewController.swift
//  YearLongPt.1
//
//  Created by Everett Brothers on 9/20/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var darkLabel: UILabel!
    var darkMode = false
    @IBOutlet var darkSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    @IBAction func swichChanged(_ sender: Any) {
        if darkSwitch.isOn {
            darkMode = true
        } else {
            darkMode = false
        }
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.dark = darkMode
        }
    }
    
    func updateUI() {
        if darkMode {
            self.view.backgroundColor = .black
            darkLabel.textColor = .white
            settingsLabel.textColor = .white
            darkSwitch.isOn = true
        } else {
            self.view.backgroundColor = .white
            darkLabel.textColor = .black
            settingsLabel.textColor = .black
            darkSwitch.isOn = false
        }
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
