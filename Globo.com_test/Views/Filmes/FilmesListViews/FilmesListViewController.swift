//
//  FilmesListViewController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit


class FilmesListViewController: UIViewController {
    
//    @IBOutlet weak var filmesTableView: UITableView!
//    fileprivate lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
//    var viewMultiplier = 0.15
//
//    fileprivate var filmesListViewModel: FilmesListViewModel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.filmesTableView.delegate = self
//        self.filmesTableView.dataSource = self
//        self.filmesListViewModel = FilmesListViewModel()
//        self.filmesListViewModel.delegate = self
//        self.filmesListViewModel.loadFilmes()
//        setupView()
//    }
//
//    func setupView() {
//        self.navigationItem.titleView = searchBar
//        searchBar.placeholder = "Busca por tītulo ou Categoria"
//    }
//
//    func filmesDidLoad() {
//        self.filmesTableView.reloadData()
//    }
//
//}
//
//extension FilmesListViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return filmesListViewModel != nil ? filmesListViewModel.numberOfCategorySections : 0
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(filmesListViewModel != nil ? filmesListViewModel.numberOfRowsPerCategorySection : 0)
//        return filmesListViewModel != nil ? filmesListViewModel.numberOfRowsPerCategorySection : 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryFilmListTableViewCell
//        cell.setupCell(controller: self, filmesListForCategory: self.filmesListViewModel.filmesPerCategory(section: indexPath.section))
//        return cell
//    }
//
////    Table view Design
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UIScreen.main.bounds.height * CGFloat(viewMultiplier)
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerHeight = UIScreen.main.bounds.height * 0.03
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: headerHeight))
//        headerView.backgroundColor = .black
//
//
//        let labelHeight = headerHeight
//        let label = UILabel(frame: CGRect(x: 20, y: 0, width: headerView.bounds.width, height: labelHeight))
//        label.textColor = .white
//        label.font = .boldSystemFont(ofSize: labelHeight - (labelHeight * 0.5))
//        label.text = filmesListViewModel.categoryTitleAt(section: section)
//        headerView.addSubview(label)
//
//        return headerView
//    }
//}
//
//extension FilmesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.filmesListViewModel != nil ? self.filmesListViewModel.numberOfFilmesPerCategorySection(section: section) : 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmeCell", for: indexPath) as! FilmeCollectionCell
//        cell.setupView(filme: self.filmesListViewModel.filmeForCellAt(indexPath: indexPath))
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let filme = self.filmesListViewModel.filmeForCellAt(indexPath: indexPath)
//        let filmeView = FilmeDetailView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), filme: filme)
//        self.view.addSubview(filmeView)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = UIScreen.main.bounds.width * 0.30
//        return CGSize(width: size, height: size)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//}
//
//extension FilmesListViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//    }
//
}
