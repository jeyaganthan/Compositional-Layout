//
//  ShopByBrandCollectionViewCell.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import UIKit

class ShopByBrandCollectionViewCell: UICollectionViewCell,ConfiguringCell {
    static var reuseableIdentifier: String = "brandcell"
    
    func configureCellLayout(with app: Items) {
        guard let img = brandImg else {return}
        Themes.shared.loadImageFromUrl(urlString: Themes.checkNull(app.icon), imageView: brandImg)
      //  brandNamelbl.text = Themes.checkNull(app.makename)
    }
    

    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandImg: UIImageView!
    @IBOutlet weak var brandNamelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        brandView.layer.cornerRadius = 10
//        brandView.layer.shadowOpacity = 0.1
//        brandView.layer.shadowOffset = .zero
        
        //brandView.layer.cornerRadius = 15
        brandView.layer.shadowColor = UIColor.init(named: "ApptextgrayColor")?.cgColor ?? UIColor.gray.cgColor
        brandView.layer.shadowOpacity = 0.3
        brandView.layer.shadowOffset = .zero
      
    }

}
