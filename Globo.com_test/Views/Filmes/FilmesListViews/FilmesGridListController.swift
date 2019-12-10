//
//  FilmesGridListController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class FilmesGridListController: UIViewController, FilmesViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate lazy var segmentedControl = UISegmentedControl(items: ["Todos os Filmes", "Favoritos"])

    fileprivate var filmesListViewModel: FilmesListViewModel!
    private var selectedFilme: FilmeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.filmesListViewModel = FilmesListViewModel()
        self.filmesListViewModel.delegate = self
        setupView()
        self.filmesListViewModel.loadFilmes()
        
    }
    
    func setupView() {
        self.segmentedControl.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        self.segmentedControl.tintColor = .white
        self.segmentedControl.backgroundColor = .orange
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    @objc func segmentedControlChanged() {
        print("State : \(self.segmentedControl.selectedSegmentIndex)")
        if segmentedControl.selectedSegmentIndex == 0 {
             self.filmesListViewModel.loadFilmes()
        } else {
            USER.readFavoriteMovies()
            self.collectionView.reloadData()
        }
    }
    
    func filmesDidLoad() {
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFilmeDetail" {
            let destination = segue.destination as? FilmePopUpDetailController
            destination?.filme = selectedFilme
        }
    }
    
    @IBAction func settingsClicked() {
        performSegue(withIdentifier: "goToSettings", sender: self)
    }
}

extension FilmesGridListController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return filmesListViewModel != nil ? filmesListViewModel.numOfFilmes : 0
        } else {
            return USER.favoriteFilmes.numOfFilmes
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmeCell", for: indexPath) as! FilmeCollectionCell
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.setupView(filme: self.filmesListViewModel.filmeForCellAt(indexPath: indexPath))
        } else {
            cell.setupView(filme: USER.favoriteFilmes.filmeForCellAt(indexPath: indexPath))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilme = self.filmesListViewModel.filmeForCellAt(indexPath: indexPath)
        performSegue(withIdentifier: "goToFilmeDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width * 0.333
        return CGSize(width: size, height: size)

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
