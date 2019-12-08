//
//  FilmeViewModel.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

struct FilmeViewModel {
    
    let filme: Filme
    
    init? (filme: [String : Any]) {
        self.filme = Filme(json: filme)!
    }
    
    var coverImage: UIImage {
        return filme.coverImage ?? UIImage(named: "Default_movie_img")!
    }
    
    var title: String {
        return filme.title
    }
    
    var subtitle: String {
        return filme.subtitle
    }
    var duration: String {
        return filme.duration
    }
    var synopsis: String {
        return filme.synopsis
    }
    
    var reviews: Int {
        return filme.reviews
    }
    
    var category: String {
        return filme.category.rawValue
    }
    
    var releasedAt: String {
        return filme.releasedAt.formmatedDateForPortuguese
    }
    
}
