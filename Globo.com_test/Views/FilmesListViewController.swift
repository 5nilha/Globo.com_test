//
//  FilmesListViewController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit


class FilmesListViewController: UIViewController {
  
    @IBOutlet weak var filmesTableView: UITableView!
    fileprivate lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    fileprivate var filmesListViewModel = FilmesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmesTableView.delegate = self
        filmesTableView.dataSource = self
        filmesTableView.estimatedRowHeight = 85.0
        filmesTableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "Busca por tītulo ou Categoria"
        populateFilmes()
    }
    
    private func populateFilmes() {
        Webservices.loadJson { (result) in
            switch result {
            case .success(let filmes):
                filmesListViewModel.setFilmes(filmes: filmes.map(FilmeViewModel.init))
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FilmesListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return filmesListViewModel != nil ? filmesListViewModel.numberOfCategorySections : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmesListViewModel != nil ? filmesListViewModel.numberOfRowsPerCategorySection : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryFilmListTableViewCell
        cell.setupCell(controller: self, filmesListForCategory: self.filmesListViewModel.filmesPerCategory(section: indexPath.section))
        return cell
    }
}

extension FilmesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmesListViewModel != nil ? self.filmesListViewModel.numberOfFilmesPerCategorySection(section: section) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmeCell", for: indexPath) as! FilmeCollectionCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = self.filmesListViewModel.filmeForCellAt(indexPath: indexPath)
        _ = FilmeDetailView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), filme: filme)
    }
}

extension FilmesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}
