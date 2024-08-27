//
//  RegisterViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 13/8/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var fullnameTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var confirmPasswordTextField : UITextField!
    
    var account : [TaiKhoan] = [TaiKhoan]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        var number = 0
        for i in account{
            print("------------\(number += 1)------------")
            print(i.fullname!)
            print(i.email!)
            print(i.username!)
            print(i.password!)
        }
    }
    
    func fetchData(){
        do{
            account = try context.fetch(TaiKhoan.fetchRequest())
        }
        catch{
            print("Error when fetching data")
        }
    }
    
    func addAccount(){
        guard let fullname = fullnameTextField.text, let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else{
            return
        }
        
        // These variable use to check exist or not exist account
        var checkEmail = false, checkUsername = false
        
        // Loop array to check
        for i in account{
            if email == i.email{
                checkEmail = true
            }
            if username == i.username{
                checkUsername = true
            }
        }
        
        // Password must be greater than or equal to 8 characters
        if password.count < 8{
            let alert = UIAlertController(title: "Notification", message: "Your password must be greater than or equal to 8 characters", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        // Branches statement
        if checkEmail == true{
            let alert = UIAlertController(title: "Warning", message: "This email already exists", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        if checkUsername == true{
            let alert = UIAlertController(title: "Warning", message: "This username already exists", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        while password != confirmPassword {
            let alert = UIAlertController(title: "Information", message: "Confirm password is not match", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
        }
        
        var newAccount = TaiKhoan(context: context)
        newAccount.fullname = fullnameTextField.text
        newAccount.email = emailTextField.text
        newAccount.username = usernameTextField.text
        newAccount.password = passwordTextField.text
        
        // Save Data
        do{
            try context.save()
            print("Register successfully")
        }
        catch{
            print("Error when saving data")
        }
        
        // Fetch Data
        fetchData()
    }
    
    @IBAction func okButton(sender : Any){
        addAccount()
        self.navigationController?.popViewController(animated: true)
    }
    
}

