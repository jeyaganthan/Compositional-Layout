//
//  HomePageNewModel.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import Foundation
protocol ConfiguringCell {
    static var reuseableIdentifier: String { get }
    func configureCellLayout(with app: Items)
}

struct Items : Codable,Hashable {
    let PreID : String?
    let mainId : String?
    let eftId : String?
    let mkId : String?
    let modId : String?
    let price : String?
    let moId : String?
    let catid : String?
    let pdfStatus : String?
    let newCarStatus : String?
    let modelYear : String?
    let vehiceType : String?
    let makename : String?
    let email : String?
    let secondaryEmail : String?
    let makeFolder : String?
    let modelName : String?
    let efuelType : String?
    let modelOptions : String?
    let car_image : String?
    let currency_name : String?
    let make_icon : String?
    let currency_flag_image : String?
    let promo_logo : String?
    let precar_image : String?
    
    let description : String?
    let image : String?
    let alt : String?
    
    let mkid : String?
   // let makename : String?
    let icon : String?
    let cat_name : String?
    
    let iD : String?
    let post_title : String?
    let post_name : String?
    let icons : String?
    
    
    
    enum CodingKeys: String, CodingKey {

        case PreID = "preId"
        case mainId = "mainId"
        case eftId = "eftId"
        case mkId = "mkId"
        case modId = "modId"
        case price = "price"
        case moId = "moId"
        case catid = "catid"
        case pdfStatus = "pdfStatus"
        case newCarStatus = "newCarStatus"
        case modelYear = "modelYear"
        case vehiceType = "vehiceType"
        case makename = "makename"
        case email = "email"
        case secondaryEmail = "secondaryEmail"
        case makeFolder = "makeFolder"
        case modelName = "modelName"
        case efuelType = "efuelType"
        case modelOptions = "modelOptions"
        case car_image = "car_image"
        case currency_name = "currency_name"
        case make_icon = "make_icon"
        case currency_flag_image = "currency_flag_image"
        case promo_logo = "promo_logo"
        case precar_image = "main_img"
        
        case description = "description"
        case image = "image"
        case alt = "alt"
        
        case mkid = "mkid"
       // case makename = "makename"
        case icon = "icon"
        case cat_name = "cat_name"
        
        
        case iD = "ID"
        case post_title = "post_title"
        case post_name = "post_name"
        case icons = "icons"
       
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        PreID = try values.decodeIfPresent(String.self, forKey: .PreID)
        mainId = try values.decodeIfPresent(String.self, forKey: .mainId)
        eftId = try values.decodeIfPresent(String.self, forKey: .eftId)
        mkId = try values.decodeIfPresent(String.self, forKey: .mkId)
        modId = try values.decodeIfPresent(String.self, forKey: .modId)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        moId = try values.decodeIfPresent(String.self, forKey: .moId)
        catid = try values.decodeIfPresent(String.self, forKey: .catid)
        pdfStatus = try values.decodeIfPresent(String.self, forKey: .pdfStatus)
        newCarStatus = try values.decodeIfPresent(String.self, forKey: .newCarStatus)
        modelYear = try values.decodeIfPresent(String.self, forKey: .modelYear)
        vehiceType = try values.decodeIfPresent(String.self, forKey: .vehiceType)
        makename = try values.decodeIfPresent(String.self, forKey: .makename)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        secondaryEmail = try values.decodeIfPresent(String.self, forKey: .secondaryEmail)
        makeFolder = try values.decodeIfPresent(String.self, forKey: .makeFolder)
        modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
        efuelType = try values.decodeIfPresent(String.self, forKey: .efuelType)
        modelOptions = try values.decodeIfPresent(String.self, forKey: .modelOptions)
        car_image = try values.decodeIfPresent(String.self, forKey: .car_image)
        currency_name = try values.decodeIfPresent(String.self, forKey: .currency_name)
        make_icon = try values.decodeIfPresent(String.self, forKey: .make_icon)
        currency_flag_image = try values.decodeIfPresent(String.self, forKey: .currency_flag_image)
        promo_logo = try values.decodeIfPresent(String.self, forKey: .promo_logo)
        precar_image = try values.decodeIfPresent(String.self, forKey: .precar_image)
        
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        alt = try values.decodeIfPresent(String.self, forKey: .alt)
        
        mkid = try values.decodeIfPresent(String.self, forKey: .mkid)
       // makename = try values.decodeIfPresent(String.self, forKey: .makename)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        cat_name  = try values.decodeIfPresent(String.self, forKey: .cat_name)
        
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        post_title = try values.decodeIfPresent(String.self, forKey: .post_title)
        post_name = try values.decodeIfPresent(String.self, forKey: .post_name)
        icons = try values.decodeIfPresent(String.self, forKey: .icons)
    }
}


struct Section: Decodable, Hashable {
    let type: String
    let title: String
    let Items: [Items]
}
