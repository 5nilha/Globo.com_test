//
//  SettingCell.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/10/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.menuLabel.adjustsFontForContentSizeCategory = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(menu: String) {
        self.menuImageView.image = UIImage(named: menu)
        self.menuLabel.text = menu
    }

}
