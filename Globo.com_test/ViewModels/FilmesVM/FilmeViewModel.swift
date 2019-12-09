//
//  FilmeViewModel.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

struct FilmeViewModel {
    private var filme: Filme
    
    init(filme: Filme) {
        self.filme = filme
    }
    
    
    init? (filmeJSON: [String : Any]) {
        let filme = Filme(json: filmeJSON)
        if let filme = filme {
            self.filme = filme
        } else {
            return nil
            
        }
    }
    
    var img: UIImage = #imageLiteral(resourceName: "Default_movie_img")
    
    var id: Int64 {
        return filme.id
    }
    
   var coverImageURL: URL? {
        let url = URL(string: filme.coverImageURL)
        return url
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
    
    var thumb: String {
        return "\(filme.thumb)"
    }
    
    var category: String {
        return filme.category
    }
    
    var releasedAt: String {
        return filme.releasedAt.formmatedDateForPortuguese
    }
    
    var defaultCoverImage : UIImage = {
        let image = UIImage(named: "Default_movie_img")!
        return image
    }()
    
    func loadCoverImage(completion: @escaping (UIImage) -> Void) {
        print("Download Started")
        if let url = self.coverImageURL {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(self.defaultCoverImage)
                    return
                }
                DispatchQueue.main.async() {
                    let image = UIImage(data: data)
                    completion(image ?? self.defaultCoverImage)
                }
            }
        } else {
            completion(self.defaultCoverImage)
        }
    }
    
    
    //MARK: -> Favorite Filmes Methods
    
    mutating func addToFavorite() {
        self.filme.create()
    }
    
    func removeFromFavorites() {
        self.filme.delete()
    }
    
}
