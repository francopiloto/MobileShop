//
//  CollectionsViewCell.swift
//  ShopifyMobile
//
//  Created by franco on 2019-01-20.
//  Copyright © 2019 franco. All rights reserved.
//

import UIKit

class CollectionsViewCell: UITableViewCell
{
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionName: UILabel!
    
/* --------------------------------------------------------------------------------------------- */
    
    override func awakeFromNib()
    {
        super.awakeFromNib();
        collectionImage.contentMode = .scaleAspectFit;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
    override func prepareForReuse()
    {
        super.prepareForReuse();
        collectionImage.sd_cancelCurrentImageLoad();
        collectionImage.image = nil;
    }
    
/* --------------------------------------------------------------------------------------------- */
    
}
