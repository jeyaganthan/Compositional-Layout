//
//  SmallTableCell.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import UIKit

class SmallTableCell: UICollectionViewCell, ConfiguringCell {
    static var reuseableIdentifier: String = "SmallTableCell"
        
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    private func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint?) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: 95, weight: .semibold)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.paragraphStyle: textStyle
            ] as [NSAttributedString.Key : Any]
        
        let imageWithOpacity = image.withAlpha(0.7)
        imageWithOpacity.draw(in: CGRect(origin: CGPoint.zero, size: imageWithOpacity.size))
                
        //vertically center (depending on font)
        let text_h = textFont.lineHeight
        let text_y = (imageWithOpacity.size.height-text_h)/2
        let text_rect = CGRect(x: 0, y: text_y, width: imageWithOpacity.size.width, height: text_h)
        text.draw(in: text_rect.integral, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
    func configureCellLayout(with travel: Items) {        
        Themes.shared.loadImageFromUrl(urlString: Themes.checkNull(travel.image), imageView: imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
