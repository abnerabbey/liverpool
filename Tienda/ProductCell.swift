//
//  ProductCell.swift
//  Liverpool
//
//  Created by Abner Abbey on 01/02/18.
//  Copyright © 2018 Abner Abbey. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {


    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let serviceManager = ServiceManager()
    
    var item: Product? {
        didSet {
            guard let item = item else { return }
            titleLabel.text = item.productName
            priceLabel.text = item.price
            if let pictureString = item.pictureUrlString {
                serviceManager.requestProductImage(urlString: pictureString, completion: { (data) in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.productImageView.image = UIImage(data: data)
                    }
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productImageView.contentMode = .scaleAspectFit
    }
}
