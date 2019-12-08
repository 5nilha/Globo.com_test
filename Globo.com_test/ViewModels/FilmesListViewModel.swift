//
//  FilmesListViewModel.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

struct FilmesListViewModel {
    public private (set) var filmes = [[FilmeViewModel]]()
    private var categories = [String]()
    
    init() {
        self.filmes.removeAll()
    }
    
    init(filmes: [FilmeViewModel]) {
        self.filmes.removeAll()
        self.setFilmes(filmes: filmes)
    }
    
    mutating func setFilmes(filmes: [FilmeViewModel]) {
        let filmesDic = Dictionary(grouping: filmes, by: { (filme) -> String in
            return filme.category
        })
               
        self.categories = filmesDic.keys.sorted()
        categories.forEach { (key) in
            if let values = filmesDic[key] {
                self.filmes.append(values)
            }
        }
    }
    
    var numberOfCategorySections: Int {
        return self.categories.count
    }
    
    var numberOfRowsPerCategorySection: Int {
        return 1
    }
    
    func numberOfFilmesPerCategorySection(section: Int) -> Int {
        return filmes[section].count
    }
    
    func filmesPerCategory(section: Int) -> [FilmeViewModel]{
        return filmes[section]
    }
    
    func filmeForCellAt(indexPath: IndexPath) -> FilmeViewModel {
        return filmes[indexPath.section][indexPath.row]
    }
}
