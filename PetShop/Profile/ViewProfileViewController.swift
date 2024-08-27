//
//  ViewProfileViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class ViewProfileViewController: UIViewController {

    @IBOutlet var fullnameTF : UITextField!
    @IBOutlet var emailTF : UITextField!
    @IBOutlet var usernameTF : UITextField!
    @IBOutlet var passwordTF : UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentAccount = fetchCurrentAccount(context: context)
        
        //Show user information
        fullnameTF.text = currentAccount?.fullname
        emailTF.text = currentAccount?.email
        usernameTF.text = currentAccount?.username
        passwordTF.text = currentAccount?.password
    }
    
}
