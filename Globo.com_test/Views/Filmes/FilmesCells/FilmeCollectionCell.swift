//
//  FilmeCollectionCell.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    private let relativeFontConstant:CGFloat = 0.1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = .white
        self.titleLabel.font = .systemFont(ofSize: self.contentView.frame.height * relativeFontConstant, weight: .medium)
        self.titleLabel.numberOfLines = 2
    }
    
    func setupView(filme: FilmeViewModel) {
        self.titleLabel.text = filme.title
        
    }
}
