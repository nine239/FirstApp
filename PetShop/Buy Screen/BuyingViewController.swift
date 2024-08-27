//
//  BuyingViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class BuyingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items = [Pet]()
    
    @IBOutlet var tbView : UITableView!
    @IBOutlet var labelTotalPrice : UILabel!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var payButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.dataSource = self
        tbView.delegate = self
        tbView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        cancelButton.layer.cornerRadius = CGFloat(20)
        payButton.layer.cornerRadius = CGFloat(20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tbView.reloadData()
        labelTotalPrice.text = "Total : \(totalPrice()) USD"
    }
    
    
    @IBAction func payButtonAction(sender : Any){
        let alert = UIAlertController(title: "Notification", message: "Do you want to pay \(totalPrice()) USD?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            HomeViewController.buyPet.removeAll()
            self.tbView.reloadData()
            self.labelTotalPrice.text = "Total : \(self.totalPrice()) USD"
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        
        present(alert, animated: true)
    }
    
    @IBAction func cancelButtonAction(sender : Any){
        let alert = UIAlertController(title: "Notification", message: "Do you want to delete all items from cart?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            HomeViewController.buyPet.removeAll()
            self.tbView.reloadData()
            self.labelTotalPrice.text = "Total : \(self.totalPrice()) USD"
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        
        present(alert, animated: true)
    }
    
    func totalPrice()->Int{
        var total = 0
        for i in HomeViewController.buyPet{
            total += Int(i.price)!
        }
        return total
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeViewController.buyPet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        cell.configureShoppingCart(name: HomeViewController.buyPet[indexPath.row].name, price: HomeViewController.buyPet[indexPath.row].price, image: HomeViewController.buyPet[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "Delete") { _, _, _ in
            HomeViewController.buyPet.remove(at: indexPath.row)
            self.tbView.reloadData()
            self.labelTotalPrice.text = "Total : \(self.totalPrice()) USD"
        }
        
        let cancelAction = UIContextualAction(style: UIContextualAction.Style.normal, title: "Cancel") { action, view, completionHandler in
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, cancelAction])
    }
}
