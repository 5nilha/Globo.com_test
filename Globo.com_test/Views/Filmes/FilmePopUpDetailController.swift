//
//  FilmePopUpDetailController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmePopUpDetailController: UIViewController {
    
    //Static Views
    @IBOutlet weak var categoryStaticLabel: UILabel!
    @IBOutlet weak var releasedAtStaticLabel: UILabel!
    @IBOutlet weak var subtitleStaticLabel: UILabel!
    @IBOutlet weak var durationStaticLabel: UILabel!
    @IBOutlet weak var thumbStaticLabel: UILabel!
    @IBOutlet weak var sinopseStaticLabel: UILabel!
    
    //Object Views
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
        self.populateView()
        self.setupUI()
        
    }
    
    private func setupUI(){
        self.categoryStaticLabel.adjustsFontForContentSizeCategory = true
        self.releasedAtStaticLabel.adjustsFontForContentSizeCategory = true
        self.subtitleStaticLabel.adjustsFontForContentSizeCategory = true
        self.durationStaticLabel.adjustsFontForContentSizeCategory = true
        self.thumbStaticLabel.adjustsFontForContentSizeCategory = true
        self.sinopseStaticLabel.adjustsFontForContentSizeCategory = true
        
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.categoryLabel.adjustsFontForContentSizeCategory = true
        self.releasedAtLabel.adjustsFontForContentSizeCategory = true
        
        self.popUpView.roundBorder(radius: 10)
        self.popUpView.border(color: .white, width: 2)
        self.addFavoritesButton.border(color: .white, width: 2)
        print("FAV filme \(filme.title)")
        if USER.favoriteFilmes.contains(filme: self.filme) {
            print("Contains filme")
            self.addFavoritesButton.tag = 1
            self.addFavoritesButton.setTitle("Remover de Favoritos", for: .normal)
        } else {
            print("Contains nao contains")
            self.addFavoritesButton.setTitle("Adicionar Favoritos", for: .normal)
            self.addFavoritesButton.tag = 0
        }
    }
    
    func populateView() {
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
