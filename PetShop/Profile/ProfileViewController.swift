//
//  ProfileViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func viewProfileAction(sender : Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "VIEW") as!  ViewProfileViewController
        vc.title = "View Profile"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changePasswordAction(sender : Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CHANGE") as! ChangePasswordViewController
        vc.title = "Change Password"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
