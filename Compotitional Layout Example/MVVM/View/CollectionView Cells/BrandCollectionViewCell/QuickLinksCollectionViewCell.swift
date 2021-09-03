//
//  QuickLinksCollectionViewCell.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import UIKit

class QuickLinksCollectionViewCell: UICollectionViewCell,ConfiguringCell {
    static var reuseableIdentifier: String = "catagery"
    
    func configureCellLayout(with app: Items) {
        switch app.post_name {
        case "page/service"://7
            brandImg.image = Themes.getImagefromPDFfile(name: "services")
        case "news-and-events"://8
            brandImg.image = Themes.getImagefromPDFfile(name: "news&events")
        case "about-us-2":
            brandImg.image = Themes.getImagefromPDFfile(name: "services")
        case "spare-parts"://6
           brandImg.image = Themes.getImagefromPDFfile(name: "spare")
        case "new-car-details": //1
            brandImg.image = Themes.getImagefromPDFfile(name: "newCars")
        case "preowned-car-details"://4
            brandImg.image = Themes.getImagefromPDFfile(name: "preowned")
        case "luxury-car-details": //2
            brandImg.image = Themes.getImagefromPDFfile(name: "luxury")
        case "rhd-car-details": //3
            brandImg.image = Themes.getImagefromPDFfile(name: "rhdcars")
        case "contact-us"://5
            print("Contact Us")
            brandImg.image = Themes.getImagefromPDFfile(name: "contactus")
        default:
            Themes.shared.loadImageFromUrl(urlString: app.icons ?? "", placeholderImage: "", imageView: brandImg)
        }
        
        //brandNamelbl.font = UIFont(name: AppFontName.italic, size: 12.0)
        
        var newtitle = ""
        if let titleStr = app.post_title {
            var newArr = titleStr.split(separator: " ")
            if  newArr.count > 1{
                newArr.insert(" \n ", at: newArr.count - 1)
            }
            
            newtitle = newArr.joined(separator: "")
            
        }
        if(newtitle == "ContactUs")
        {
            brandNamelbl.text = "Contact Us"
        }
        else
        {
            brandNamelbl.text = newtitle
        }
        brandNamelbl.text = Themes.checkNull(app.makename)
    }
    

    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak  var brandImg: UIImageView!
    @IBOutlet weak var brandNamelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        brandView.layer.cornerRadius = 10
//        brandView.layer.shadowOpacity = 0.1
//        brandView.layer.shadowOffset = .zero
        
        //brandView.layer.cornerRadius = 15
//        brandView.layer.shadowColor = UIColor.init(named: "ApptextgrayColor")?.cgColor ?? UIColor.gray.cgColor
//        brandView.layer.shadowOpacity = 0.8
//        brandView.layer.shadowOffset = .zero
      
    }

}
