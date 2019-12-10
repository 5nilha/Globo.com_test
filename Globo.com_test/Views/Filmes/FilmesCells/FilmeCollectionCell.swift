//
//  FilmeCollectionCell.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCellWidth: NSLayoutConstraint!
    @IBOutlet weak var viewCellHeight: NSLayoutConstraint!
    
    
    //Static views
    @IBOutlet weak var releasedAtStaticLabel: UILabel!
    @IBOutlet weak var subtitleStaticLabel: UILabel!
    @IBOutlet weak var durationStaticLabel: UILabel!
    
    
    //Dinamic Object Views
    @IBOutlet weak var filmeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedAtLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    private var relativeSize:CGFloat = 0.30
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
        self.contentView.translatesAutoresizingMaskIntoConstraints = true
        
        if UIDevice.current.model == "iPhone" {
            self.relativeSize = UIScreen.main.bounds.width * 0.30
            self.viewCellWidth.constant = relativeSize
            self.viewCellHeight.constant = relativeSize
        } else {
            self.relativeSize = UIScreen.main.bounds.width * 0.23
            self.viewCellWidth.constant = relativeSize
            self.viewCellHeight.constant = relativeSize
        }
    }
    
    private func setupUI() {
        self.releasedAtStaticLabel.adjustsFontForContentSizeCategory = true
        self.subtitleStaticLabel.adjustsFontForContentSizeCategory = true
        self.durationStaticLabel.adjustsFontForContentSizeCategory = true
        
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.releasedAtLabel.adjustsFontForContentSizeCategory = true
        self.subtitleStaticLabel.adjustsFontForContentSizeCategory = true
        
         self.titleLabel.font = .systemFont(ofSize: 17 - (17 * relativeSize), weight: .medium)
        self.releasedAtStaticLabel.font = .systemFont(ofSize: 10 - (10 * relativeSize), weight: .medium)
        self.subtitleStaticLabel.font = .systemFont(ofSize: 10 - (10 * relativeSize), weight: .medium)
        self.durationStaticLabel.font = .systemFont(ofSize: 10 - (10 * relativeSize), weight: .medium)
        
        self.filmeView.border(color: .white, width: 2.0)
        self.titleLabel.textColor = .white
        self.titleLabel.numberOfLines = 2
    }
    
    func setupView(filme: FilmeViewModel) {
        self.titleLabel.text = filme.title
        self.releasedAtLabel.text = filme.releasedAt
        self.subtitleLabel.text = filme.subtitle
        self.durationLabel.text = filme.duration
        
    }
}
