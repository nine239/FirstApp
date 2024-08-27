//
//  LoginViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 13/8/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var loginButton : UIButton!
    @IBOutlet var registerButton : UIButton!
    
    var account : [TaiKhoan] = [TaiKhoan]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        registerButton.layer.cornerRadius = 20
        fetchData()
//        for i in account{
//            print(i.username)
//            print(i.password)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
    }
    
    func fetchData(){
        do{
            account = try context.fetch(TaiKhoan.fetchRequest())
        }
        catch{
            print("Error when fetching data")
        }
    }
    
    @IBAction func loginButtonAction(sender : Any){
        guard let tendangnhap = usernameTextField.text, let matkhau = passwordTextField.text else{
            return
        }
        
        if tendangnhap.isEmpty && matkhau.isEmpty{
            let alert = UIAlertController(title: "Notification", message: "You must enter username and password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
            return
        }
        else if tendangnhap.isEmpty && !matkhau.isEmpty{
            let alert = UIAlertController(title: "Notification", message: "You must enter username", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
            return
        }
        else if !tendangnhap.isEmpty && matkhau.isEmpty{
            let alert = UIAlertController(title: "Notification", message: "You must enter password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
            return
        }
        
        var checkLogin = false
        for i in 0..<account.count{
            if tendangnhap == account[i].username && matkhau == account[i].password{
                checkLogin = true
                let tabbarController = storyboard?.instantiateViewController(identifier: "Tabbar") as! UITabBarController
                tabbarController.modalPresentationStyle = .fullScreen
                present(tabbarController, animated: true)
                UserDefaults.standard.set(usernameTextField.text, forKey: "currentUsername")
            }
        }
        if checkLogin == false{
            let alert = UIAlertController(title: "Processing login", message: "Username or password is not correct", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func registerButtonAction(sender : Any){
        let vc = storyboard?.instantiateViewController(identifier: "REGISTER") as! RegisterViewController as RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}

func fetchCurrentAccount(context : NSManagedObjectContext)->TaiKhoan?{
    if let currentUsername = UserDefaults.standard.string(forKey: "currentUsername"){
        let fetchRequest : NSFetchRequest<TaiKhoan> = TaiKhoan.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", currentUsername)
        
        do{
            let account = try context.fetch(fetchRequest)
            return account.first
        }
        catch{
            print("Failed to fetch current account: \(error)")
            return nil
        }
    }
    return nil
}
