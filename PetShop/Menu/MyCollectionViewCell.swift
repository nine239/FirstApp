//
//  MyCollectionViewCell.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView : UIImageView!
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var priceLabel : UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Custom label corner
        nameLabel.layer.cornerRadius = 15
        priceLabel.layer.cornerRadius = 15
        
        nameLabel.textAlignment = .center
        priceLabel.textAlignment = .center
        
        nameLabel.clipsToBounds = true
        priceLabel.clipsToBounds = true
    }

    public func configure(imageName : String, name : String, price : String){
        imageView.image = UIImage(named: imageName)
        nameLabel.text = name
        priceLabel.text = "\(price) USD"
    }
}
