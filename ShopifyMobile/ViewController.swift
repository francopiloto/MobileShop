//
//  ViewController.swift
//  ShopifyMobile
//
//  Created by franco on 2019-01-20.
//  Copyright © 2019 franco. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController
{
    
/* --------------------------------------------------------------------------------------------- */
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        Utils.loadData(url: Utils.URL, onCompleted:
        {
            response in
            
            if (response == JSON.null) {
                return;
            }
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
            
            let viewController = storyBoard.instantiateViewController(withIdentifier: "collections") as! CollectionsViewController;
            viewController.collectionData = response["custom_collections"];
            
            self.present(viewController, animated: true, completion: nil);
        });
    }
    
/* --------------------------------------------------------------------------------------------- */

}

