//
//  Utils.swift
//  ShopifyMobile
//
//  Created by franco on 2019-01-20.
//  Copyright © 2019 franco. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Utils
{
    static let URL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6";
    
    static let COLLECTS_URL = "https://shopicruit.myshopify.com/admin/collects.json?collection_id={ID}&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6";
    
    static let PRODUCTS_URL = "https://shopicruit.myshopify.com/admin/products.json?ids={IDS}&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6";
    
    
    static let RESIZE_FACTOR = UIScreen.main.bounds.width / 375;
    
    private static let green = color(rgb: 0x258255);
    private static let pink = color(rgb: 0xDAC8BA);
    private static let gray = color(rgb: 0xE8ECEB);
    private static let disabled = color(rgb: 0x666666);
    
/* --------------------------------------------------------------------------------------------- */
    
    static func loadData(url: String, onCompleted: @escaping (JSON)->Void)
    {
        Alamofire.request(url, method: .get, parameters: nil).responseJSON
        {
            response in
            
            if (response.result.isSuccess)
            {
                if let responseData = response.data
                {
                    do
                    {
                        let jsonData = try JSON(data: responseData);
                        onCompleted(jsonData);
                        return;
                    }
                    catch {}
                }
            }
            
            onCompleted(JSON.null);
        }
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    static func configure(button: UIButton)
    {
        button.layer.cornerRadius = 4 * RESIZE_FACTOR;
        button.layer.borderColor = pink.cgColor;
        button.layer.backgroundColor = gray.cgColor;
        button.setTitleColor(green, for: .normal);
        button.setTitleColor(pink, for: .highlighted);
        
        button.layer.borderWidth = 2;
        button.setTitleColor(disabled, for: .disabled);
        
        adjustFontSize(label: button.titleLabel!);
    }
    
/* --------------------------------------------------------------------------------------------- */

    static func adjustFontSize(label: UILabel) {
        label.font = label.font.withSize(label.font.pointSize * RESIZE_FACTOR);
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    static func color(rgb: Int) -> UIColor
    {
        return UIColor(red:   CGFloat((rgb >> 16) & 0xFF) / 255.0,
                       green: CGFloat((rgb >>  8) & 0xFF) / 255.0,
                       blue:  CGFloat((rgb >>  0) & 0xFF) / 255.0,
                       alpha: 1.0);
    }

/* --------------------------------------------------------------------------------------------- */

}
