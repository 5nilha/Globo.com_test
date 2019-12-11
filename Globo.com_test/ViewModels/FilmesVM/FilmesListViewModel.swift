//
//  FilmesListViewModel.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

class FilmesListViewModel {
    private var filmes: [FilmeViewModel]
    var delegate: FilmesViewDelegate!
    
    init() {
        self.filmes = [FilmeViewModel]()
    }

    var numOfFilmes: Int {
    return filmes.count
    }
    
    func filmeForCellAt(indexPath: IndexPath) -> FilmeViewModel {
        return filmes[indexPath.row]
    }
    
    func clear() {
        filmes.removeAll()
    }
    
    func readFavorites(userId: Int64) {
        var filmesVM = [FilmeViewModel]()
        for filme in Filme.read(for: userId) {
            filmesVM.append(FilmeViewModel(filme: filme))
        }
        self.filmes = filmesVM
        if self.delegate != nil {
            self.delegate.filmesDidLoad()
        }
    }
    
    func removeFromFavorites(filme: FilmeViewModel) {
        for index in 0...filmes.count-1 {
            if filme.id == filmes[index].id {
                filmes.remove(at: index)
                break
            }
        }
        filme.removeFromFavorites()
    }
    
    func contains(filme: FilmeViewModel) -> Bool {
        if self.filmes.contains(where: { (favorite) -> Bool in
            return filme.id == favorite.id
        }) {
            return true
        } else {
            return false
        }
    }
    
    // loadFilmes() Loads the Json from a remote URL
    func loadFilmes() {
        Webservices.fetchFilmes { [unowned self](filmesViewModel) in
            self.filmes.removeAll()
            if filmesViewModel != nil {
                self.filmes = filmesViewModel!.sorted(by: { (a, b) -> Bool in
                    return a.title < b.title
                })
            }
            if self.delegate != nil {
                self.delegate.filmesDidLoad()
            }
        }
    }
    

}
