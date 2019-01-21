//
//  DetailsViewCellTableViewCell.swift
//  ShopifyMobile
//
//  Created by franco on 2019-01-20.
//  Copyright © 2019 franco. All rights reserved.
//

import UIKit

class CollectionDetailsViewCell: UITableViewCell
{
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var collection: UILabel!
    @IBOutlet weak var available: UILabel!
    
/* --------------------------------------------------------------------------------------------- */
    
    override func awakeFromNib()
    {
        super.awakeFromNib();
        productImage.contentMode = .scaleAspectFit;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    override func prepareForReuse()
    {
        super.prepareForReuse();
        productImage.sd_cancelCurrentImageLoad();
        productImage.image = nil;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
}
