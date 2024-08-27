//
//  HomeViewController.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var collectionView : UICollectionView!
    var pets : [Pet] = []
    static var buyPet : [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.blue // Màu của item được chọn
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray // Màu của item không được chọn
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        loadPetFromJson()
        for i in pets{
            print(i)
        }
    }
    
    func loadPetFromJson(){
        if let path = Bundle.main.path(forResource: "PetData", ofType: "json"){
            let url = URL(fileURLWithPath: path)
            do{
                let data = try Data(contentsOf: url)
                pets = try JSONDecoder().decode([Pet].self, from: data)
                collectionView.reloadData()
            }
            catch{
                print("Error loading json : \(error)")
            }
        }
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let alert = UIAlertController(title: "Inform", message: "Do you want to buy this pet ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            HomeViewController.buyPet.append(self.pets[indexPath.row])
        }))
        present(alert, animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.configure(imageName: pets[indexPath.row].image, name: pets[indexPath.row].name, price: pets[indexPath.row].price)
        return cell
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (view.frame.size.width - 20)/2
        let h = (view.frame.size.height - 40)/2
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

struct Pet : Codable{
    var name : String
    var price : String
    var image : String
}

