//
//  Filme.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

struct Filme {
    public private (set) var id: Int64
    let coverImageURL: String
    let title: String
    let subtitle: String
    let duration: String
    let synopsis: String
    let thumb: Int
    let category: String!
    let releasedAt: Date!
    
    init(id: Int64, coverImageURL: String, title: String, subtitle: String, duration: String, synopsis: String, thumb: Int, category: String, releasedAt: Int) {
        self.id = id
        self.coverImageURL = coverImageURL
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.synopsis = synopsis
        self.thumb = thumb
        self.category = category
        self.releasedAt = Date(timeIntervalSince1970: Double(releasedAt))
    }

    init?(json: [String : Any]) {
        guard let coverImageURL = json["cover_image"] as? String,
            let title =  json["title"] as? String,
            let subtitle = json["subtitle"] as? String,
            let duration = json["duration"] as? String,
            let synopsis = json["synopsis"] as? String,
            let thumb = json["reviews"] as? Int,
            let category = json["movie_category"] as? String,
            let releasedAt = json["released_at"] as? Int
        else {
            return nil
        }
        
        self.id = 0
        self.coverImageURL = coverImageURL
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.synopsis = synopsis
        self.thumb = thumb
        self.category = category
        self.releasedAt = Date(timeIntervalSince1970: Double(releasedAt))
    }
    
    
    mutating func create() {
        let id = FavoriteFilmeEntity.shared.create(ccoverImageURL: self.coverImageURL,
                                                   ctitle: self.title,
                                                   csubtitle: self.subtitle,
                                                   cduration: self.duration,
                                                   csynopsis: self.synopsis,
                                                   cthumb: self.thumb,
                                                   ccategory: self.category,
                                                   creleasedAt: Int(self.releasedAt.timeIntervalSince1970),
                                                   cuserID: USER!.id)
        self.id = id
    }
    
    static func read() -> [Filme] {
        let filmes = FavoriteFilmeEntity.shared.read()
        return filmes
    }
    
    
    func update() {
        _ = FavoriteFilmeEntity.shared.update(cid: self.id, filme: self)
    }
    
    func delete() {
       let deleted = FavoriteFilmeEntity.shared.delete(filme: self)
        print("is deleted = \(deleted)")
    }
    
    
}
