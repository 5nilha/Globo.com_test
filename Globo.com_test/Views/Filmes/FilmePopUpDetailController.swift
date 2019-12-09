//
//  FilmePopUpDetailController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmePopUpDetailController: UIViewController {
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var releasedAtLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var thumbLabel: UILabel!
    @IBOutlet weak var addFavoritesButton: UIButton!
    @IBOutlet weak var sinopseTextView: UITextView!
    
    var filme: FilmeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView() {
        self.popUpView.roundBorder(radius: 10)
        self.addFavoritesButton.border(color: .white, width: 2)
        if let filme = filme {
            self.titleLabel.text = filme.title
            self.categoryLabel.text = filme.category
            self.releasedAtLabel.text = filme.releasedAt
            self.subtitleLabel.text = filme.subtitle
            self.durationLabel.text = filme.duration
            self.thumbLabel.text = filme.thumb
            self.sinopseTextView.text = filme.synopsis
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
        if USER.favoriteFilmes.contains(filme: self.filme) {
            self.addFavoritesButton.tag = 1
            self.addFavoritesButton.setTitle("Remover de Favoritos", for: .normal)
        } else {
            self.addFavoritesButton.setTitle("Adicionar Favoritos", for: .normal)
            self.addFavoritesButton.tag = 0
        }
    }

    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addFavoritesClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            self.addFavoritesButton.tag = 1
            filme.addToFavorite()
            self.addFavoritesButton.setTitle("Remover de Favoritos", for: .normal)
        } else {
            USER.favoriteFilmes.removeFromFavorites(filme: filme)
            filme.removeFromFavorites()
             self.addFavoritesButton.tag = 0
            self.addFavoritesButton.setTitle("Adicionar Favoritos", for: .normal)
        }
        
    }
}
