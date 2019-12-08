//
//  Filme.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit
enum MovieCategory: String, Codable, CaseIterable, Comparable {
    static func < (lhs: MovieCategory, rhs: MovieCategory) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    case action = "Açåo"
    case adventure = "Aventura"
    case comedies = "Comédia"
    case horror = "Terror"
    case Romantic = "Romatico"
    case sci_fi = "Ficção Cientifica"
    case Drama_Comedy = "Comédia e Drama"
}
struct Filme {
    
    let coverImage: UIImage?
    let title: String
    let subtitle: String
    let duration: String
    let synopsis: String
    let reviews: Int
    let category: MovieCategory
    let releasedAt: Date
    
    init?(json: [String : Any]) {
        guard let title =  json["title"] as? String,
            let subtitle = json["subtitle"] as? String,
            let duration = json["duration"] as? String,
            let synopsis = json["synopsis"] as? String,
            let reviews = json["reviews"] as? Int,
            let category = MovieCategory(rawValue: (json["category"] as? String)!),
            let releasedAt = json["releasedAt"] as? Double
        else {
            return nil
        }
        
        self.coverImage = nil
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.synopsis = synopsis
        self.reviews = reviews
        self.category = category
        self.releasedAt = Date(timeIntervalSince1970: releasedAt)
    }
}
