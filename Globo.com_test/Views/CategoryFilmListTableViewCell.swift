//
//  CategoryFilmListTableViewCell.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class CategoryFilmListTableViewCell: UITableViewCell {
    
    fileprivate var collectionView : UICollectionView!
    fileprivate var filmesListForCategory: [FilmeViewModel]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 10, y: 10, width: self.contentView.frame.width, height: contentView.frame.height), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilmeCollectionCell.self, forCellWithReuseIdentifier: "filmeCell")
        self.contentView.addSubview(collectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(controller: FilmesListViewController?, filmesListForCategory: [FilmeViewModel]) {
        
        //Setup the collection view delegate to the passed controller
        guard let vc = controller else { return }
        self.collectionView.delegate = vc
        self.collectionView.dataSource = vc
        self.filmesListForCategory = filmesListForCategory
    }
}

