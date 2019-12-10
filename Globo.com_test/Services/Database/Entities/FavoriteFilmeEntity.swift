//
//  FilmeEntity.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation
import SQLite

class FavoriteFilmeEntity: Database {
    static let shared = FavoriteFilmeEntity()
    
    //Daatabase Table
    private let tblFilmes = Table("favorite_filmes")
    
    let id = Expression<Int64>("id")
    let coverImageURL = Expression<String>("cover_image_url")
    let title = Expression<String>("title")
    let subtitle = Expression<String>("subtitle")
    let duration = Expression<String>("duration")
    let synopsis = Expression<String>("synopsis")
    let thumb = Expression<Int64>("thumb")
    let category = Expression<String>("category")
    let releasedAt = Expression<Int64>("releasedAt")
    let userID = Expression<Int64>("user_id")
    
    private override init() {
        super.init()
        do {
            try self.dbConnection!.run(self.tblFilmes.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                table.column(self.id, primaryKey: true)
                table.column(self.coverImageURL)
                table.column(self.title)
                table.column(self.subtitle)
                table.column(self.duration)
                table.column(self.synopsis)
                table.column(self.thumb)
                table.column(self.category)
                table.column(self.releasedAt)
                table.column(self.userID)
            }))
        } catch {
            print("users table creation failed. Error: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: -> CRUD Operations
    func create(ccoverImageURL: String, ctitle: String, csubtitle: String, cduration: String, csynopsis: String, cthumb: Int64, ccategory: String, creleasedAt: Int64, cuserID: Int64) -> Int64 {
        do {
            let insert = self.tblFilmes.insert(coverImageURL <- ccoverImageURL,
                                               title <- ctitle,
                                               subtitle <- csubtitle,
                                               duration <- cduration,
                                               synopsis <- csynopsis,
                                               thumb <- cthumb,
                                               category <- ccategory,
                                               releasedAt <- creleasedAt,
                                               userID <- cuserID)
            let id = try dbConnection!.run(insert)
            return id
        } catch {
            return -1
        }
    }
    
    func read(for userId: Int64 ) -> [Filme] {
        var favFilmes = [Filme]()
        
        do {
            for filme in try dbConnection!.prepare("SELECT * FROM favorite_filmes WHERE user_id = \(userId) ") {
                print("FIlms \(filme[2] as! String)")
                favFilmes.append(Filme(id: filme[0] as! Int64,
                                       coverImageURL: filme[1] as! String,
                                       title: filme[2] as! String,
                                       subtitle: filme[3] as! String,
                                       duration: filme[4] as! String,
                                       synopsis: filme[5] as! String,
                                       thumb: filme[6] as! Int64,
                                       category: filme[7] as! String,
                                       releasedAt: filme[8] as! Int64))
            }
        } catch {
            print("Select failed")
        }
        return favFilmes
    }
    
    func update(cid: Int64, filme: Filme) -> Bool {
        let filmeData = tblFilmes.filter(id == cid)
        do {
            let update = filmeData.update([
                coverImageURL <- filme.coverImageURL,
                title <- filme.title,
                subtitle <- filme.subtitle,
                duration <- filme.duration,
                synopsis <- filme.synopsis,
                thumb <- filme.thumb,
                category <- filme.category,
                releasedAt <- Int64(filme.releasedAt.timeIntervalSince1970)
                ])
            if try self.dbConnection!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }

        return false
    }
    
    func delete(filme: Filme) -> Bool{
        do {
            let filme = tblFilmes.filter(title == filme.title)
            try self.dbConnection!.run(filme.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
}
