//
//  MyTableViewCell.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 14/8/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let identifier = "MyTableViewCell"
    
    static func nib()->UINib{
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    @IBOutlet var imgView : UIImageView!
    @IBOutlet var labelName : UILabel!
    @IBOutlet var labelPrice : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureShoppingCart(name : String, price : String, image : String){
        imgView.image = UIImage(named: image)
        labelName.text = name
        labelPrice.text = price
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
