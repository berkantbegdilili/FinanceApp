//
//  AltinTVCell.swift
//  Doviz
//
//  Created by Berkant Beğdilili on 15.05.2020.
//  Copyright © 2020 Berkant Beğdilili. All rights reserved.
//

import UIKit

class AltinTVCell: UITableViewCell {

    
    @IBOutlet weak var isim: UILabel!
    @IBOutlet weak var guncelleme: UILabel!
    @IBOutlet weak var alis: UILabel!
    @IBOutlet weak var satis: UILabel!
    @IBOutlet weak var fark: UILabel!
    @IBOutlet weak var farkImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
