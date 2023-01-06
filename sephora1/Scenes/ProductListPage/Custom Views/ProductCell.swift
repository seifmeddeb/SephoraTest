//
//  ProductCell.swift
//  sephora1
//
//  Created by Seif Meddeb on 05/01/2023.
//

import UIKit
class ProductCell : UITableViewCell {
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var productPriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .black
        return label
        
    }()
    
    private let productImage : UIImageView = {
        let imgView = UIImageView(image: nil)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let isSpecialImage : UIImageView = {
        let image = UIImage(systemName: "star.fill")
        let imgView = UIImageView(image: image)
        imgView.tintColor = .systemPink
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(isSpecialImage)
        addSubview(productDescriptionLabel)
        addSubview(productPriceLabel)
        
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 50, width: frame.size.width - 110, height: 0, enableInsets: false)
        isSpecialImage.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 20, height: 20, enableInsets: false)
        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        productPriceLabel.anchor(top: productDescriptionLabel.bottomAnchor, left: productImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = nil
    }

    func setup(with product: DisplayableProduct) {
        productNameLabel.text = product.name
        productDescriptionLabel.text = product.description
        productPriceLabel.text = product.price
        if let imageURL = product.imageURL {
            productImage.loadImageUsingCache(withUrl: imageURL)
        }
        isSpecialImage.isHidden = !product.isSpecialBrand
    }
    
}
