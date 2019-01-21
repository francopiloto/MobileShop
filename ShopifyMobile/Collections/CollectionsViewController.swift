//
//  CollectionsViewController.swift
//  ShopifyMobile
//
//  Created by franco on 2019-01-20.
//  Copyright © 2019 franco. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class CollectionsViewController: UITableViewController
{
    var collectionData : JSON?;
    private let cellHeight = UIScreen.main.bounds.height / 5;
    
/* --------------------------------------------------------------------------------------------- */
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }

/* --------------------------------------------------------------------------------------------- */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
/* --------------------------------------------------------------------------------------------- */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionData != nil ? (collectionData?.count)! : 0;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! CollectionsViewCell;
        
        let collection = collectionData![indexPath.row];
        
        cell.collectionName.text = collection["title"].stringValue;
        
        cell.collectionImage.sd_setImage(with: URL(string: collection["image"]["src"].stringValue), placeholderImage: UIImage(named: "Unknown"));
        
        return cell;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadProducts(collection: collectionData![indexPath.row]);
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    private func loadProducts(collection: JSON)
    {
        let collectionId = collection["id"].stringValue;
        let collectionName = collection["title"].stringValue;
        
        Utils.loadData(url: Utils.COLLECTS_URL.replacingOccurrences(of: "{ID}", with: collectionId), onCompleted:
        {
            response in
            
            if (response == JSON.null) {
                return;
            }
            
            var ids : [String] = [];
            
            for collect in response["collects"] {
                ids.append(collect.1["product_id"].stringValue);
            }
            
            Utils.loadData(url: Utils.PRODUCTS_URL.replacingOccurrences(of: "{IDS}", with: ids.joined(separator: ",")), onCompleted:
            {
                response in
                
                if (response == JSON.null) {
                    return;
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
                
                let viewController = storyBoard.instantiateViewController(withIdentifier: "details") as! CollectionDetailsViewController;
                
                viewController.collectionData = self.collectionData;
                viewController.productData = response["products"];
                viewController.collectionName = collectionName;
                
                self.present(viewController, animated: true, completion: nil);
            });
        });
    }
    
/* --------------------------------------------------------------------------------------------- */
    
}
