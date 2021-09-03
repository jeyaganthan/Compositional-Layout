//
//  NewyearCollectionViewCell.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import UIKit


protocol DidTapLoginDelegate {
    func didTapLogin()
}

class NewyearCollectionViewCell: UICollectionViewCell,ConfiguringCell {
    static var reuseableIdentifier: String = "offerCell"
    
    func configureCellLayout(with app: Items) {
        Themes.shared.loadImageFromUrl(urlString: Themes.checkNull(app.promo_logo), imageView: offerImage)
        Themes.shared.loadImageFromUrl(urlString: Themes.checkNull(app.car_image), imageView: carimg)
        //Themes.shared.loadImageFromUrl(urlString: Themes.checkNull(app.car_image), imageView: <#T##UIImageView#>)
    }
    
    
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet var carimg : UIImageView!
    @IBOutlet var cartype: UILabel!
    @IBOutlet var bottomlbl: UILabel!
    @IBOutlet var vehicleTypeimg: UIImageView!
    @IBOutlet var yearlbl: UILabel!
    @IBOutlet var dateimg: UIImageView!
    @IBOutlet var modelNamelbl : UILabel!
   // @IBOutlet weak var currentFlagImg: UIImageView!
    @IBOutlet var vehicleTypelbl: UILabel!
    @IBOutlet weak var btnLoginforPrice: UIButton!
    @IBOutlet weak var carBrandImg: UIImageView!
    var delegate:DidTapLoginDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
           // self.mainCellView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
            self.mainCellView.layer.cornerRadius = 10
            self.mainCellView.layer.shadowColor = UIColor.init(named: "ApptextgrayColor")?.cgColor ?? UIColor.gray.cgColor
            self.mainCellView.layer.shadowOpacity = 0.6
            self.mainCellView.layer.shadowOffset = .zero
            //self.carimg.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        }
    }
    
    
    
    
   
    
 @IBAction func didTapGoToLoginView(_ sender: UIButton) {
    self.delegate?.didTapLogin()
    }


}


class FixedWidthAspectFitImageView: UIImageView
{

    override var intrinsicContentSize: CGSize
    {
        // VALIDATE ELSE RETURN
        // frameSizeWidth
        let frameSizeWidth = self.frame.size.width

        // image
        // ⓘ In testing on iOS 12.1.4 heights of 1.0 and 0.5 were respected, but 0.1 and 0.0 led intrinsicContentSize to be ignored.
        guard let image = self.image else
        {
            return CGSize(width: frameSizeWidth, height: 1.0)
        }

        // MAIN
        let returnHeight = ceil(image.size.height * (frameSizeWidth / image.size.width))
        return CGSize(width: frameSizeWidth, height: returnHeight)
    }

}


