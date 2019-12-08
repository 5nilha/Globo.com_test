//
//  FilmeCollectionCell.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmeCollectionCell: UICollectionViewCell {
    func setupView(filme: FilmeViewModel) {
        let imageRec: CGFloat = 80.0
        let titleHeight: CGFloat = 20.0
        
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height))
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 10
        vStack.distribution = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        cellView.addSubview(vStack)
        
        //Set the imageview
        let filmeImageView = UIImageView(frame: CGRect(x: (cellView.frame.width / 2) - (imageRec / 2), y: cellView.frame.origin.y + 8, width: imageRec, height: imageRec))
        filmeImageView.image = filme.coverImage
        filmeImageView.roundBorder(radius: 6)
        vStack.addArrangedSubview(filmeImageView)
        
        //Set the title label
        let titleLabel = UILabel(frame: CGRect(x: cellView.frame.origin.x + 10, y: cellView.frame.origin.y + 8, width: cellView.frame.width, height: titleHeight))
        titleLabel.text = filme.title
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        vStack.addArrangedSubview(titleLabel)
        
        self.contentView.addSubview(cellView)
        
    }
}
