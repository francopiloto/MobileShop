//
//  DetailsViewController.swift
//  ShopifyMobile
//
//  Created by franco on 2019-01-20.
//  Copyright © 2019 franco. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class CollectionDetailsViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btBack: UIButton!
    
    var collectionData : JSON?;
    var productData : JSON?;
    var collectionName : String?;
    
    private let cellHeight = UIScreen.main.bounds.height / 5;
    
/* --------------------------------------------------------------------------------------------- */
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        Utils.configure(button: btBack);
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as! CollectionsViewController;
        vc.collectionData = collectionData;
    }
    
/* --------------------------------------------------------------------------------------------- */

}

extension CollectionDetailsViewController : UITableViewDataSource
{
    
/* --------------------------------------------------------------------------------------------- */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData != nil ? (productData?.count)! : 0;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! CollectionDetailsViewCell;
        
        let product = productData![indexPath.row];
        
        cell.productName.text = product["title"].stringValue;
        cell.collection.text = "Collection: \(self.collectionName!)";
        
        var available : Int = 0;
        
        for variant in product["variants"] {
            available += variant.1["inventory_quantity"].intValue;
        }
        
        cell.available.text = "Available: \(available)";
        
        cell.productImage.sd_setImage(with: URL(string: product["image"]["src"].stringValue), placeholderImage: UIImage(named: "Unknown"));
        
        return cell;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    
}

extension CollectionDetailsViewController : UITableViewDelegate
{
    
/* --------------------------------------------------------------------------------------------- */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
}
