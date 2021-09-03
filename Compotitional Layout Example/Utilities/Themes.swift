//
//  Themes.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import Foundation
import SDWebImage

class Themes: NSObject {
    /// Access the whole class with this single instance
    static let shared = Themes()
    
    // MARK:- Check Null Vlaues in String.
    /// This Function to helps to avoid the crashes during the the check of null values in String and this function convert the Any data type to string
    /// - Parameter str: you give `Any`
    /// - Returns: It Will return as Empty if the `str` is null or nill it will return a empty string.
   static func checkNull(_ str:Any?) -> String{ return str is NSNull || str == nil ? "" : String(describing: str!)}
  //MARK:- Load the imageString to ImageView
    /// This function helps to load the image from web URL to Imageciew with cahe by help of SDWebImage
    /// - Parameters:
    ///   - urlString: Image web URL
    ///   - placeholderImage: Place holder Image Name
    ///   - imageView: Which Imageview to Load the Image
    /// - Returns: empty
    func loadImageFromUrl(urlString:String,placeholderImage:String = "",imageView:UIImageView) -> Void
    {
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.sd_setImage(with: URL(string:urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), placeholderImage: UIImage(named: ""))

    }
    //MARK:- Image Loading From PDF
    
    /// This function to load the PDF images
    /// - Parameter name: Pdf file name string
    /// - Returns: as UIImage
    static func getImagefromPDFfile(name:String) -> UIImage{
        let pdfFilePath = Bundle.main.url(forResource: name, withExtension: "pdf")
        let Image = Themes.drawPDFfromURL(url:pdfFilePath!)
        return Image ?? UIImage()
    }
    
    /// This function to draw the Image from PDF File
    /// - Parameter url: PDF Flie URL
    /// - Returns: converted pdf image
    static func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            ctx.cgContext.drawPDFPage(page)
        }
        return img
    }
}
