//
//  ChangePasswordViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet var oldPasswordTF : UITextField!
    @IBOutlet var newPasswordTF : UITextField!
    @IBOutlet var confirmPasswordTF : UITextField!
    @IBOutlet var okButton : UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        okButton.layer.cornerRadius = 20
    }
    
    @IBAction func okButtonAction(sender : Any){
        let currentAccount = fetchCurrentAccount(context: context)
        
        //Check old password if old password similar to current password
        guard let oldPassword = oldPasswordTF.text else{
            return
        }
        
        if oldPassword.isEmpty{
            let alert = UIAlertController(title: "Notification", message: "You must enter old password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
        }
        else{
            if oldPassword == currentAccount?.password{
                guard let newPassword = newPasswordTF.text, let confirmPassword = confirmPasswordTF.text else{
                    return
                }
                if newPassword.count >= 8{
                    if confirmPassword == newPassword{
                        let label = UILabel(frame: CGRect(x: 80, y: 550, width: 250, height: 50))
                        currentAccount?.password = newPassword
                        do{
                            try context.save()
                            print("Account updated successfully")
                        }
                        catch{
                            print("Error when update account")
                        }
                        label.text = "Change password successfully"
                        label.textAlignment = .center
                        label.backgroundColor = view.backgroundColor
                        label.textColor = .systemGreen
                        self.view.addSubview(label)
                    }
                    else{
                        let alert = UIAlertController(title: "Notification", message: "Confirm password is not match", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        present(alert, animated: true)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Notification", message: "New password must be greater than or equal to 8 characters", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    present(alert, animated: true)
                }
            }
            else{
                let alert = UIAlertController(title: "Notification", message: "Old password is not correct", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alert, animated: true)
            }
        }
    }
    
}
