//
//  UserViewModel.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/8/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

var USER: UserViewModel!

class UserViewModel {
    
    private var user: User!
    public private (set) lazy var favoriteFilmes = FilmesListViewModel()
    
    init(email: String) {
        self.user = User.read(email: email)
        favoriteFilmes.readFavorites()
    }
    
    init(firstName: String, lastName: String, email: String) {
        self.user = User(id: -1, firstName: firstName, lastName: lastName, email: email)
        user.create()
        self.favoriteFilmes = FilmesListViewModel()
    }
    
    var id: Int64 {
        return self.user.id!
    }
    
    var firstName: String {
        return self.user.firstName
    }
    
    var lastName: String {
        return self.user.lastName
    }
    
    var fullName: String {
        return "\(String(describing: self.user.firstName)) \(String(describing: self.user.lastName))"
    }
    
    var email: String {
        return self.user.email
    }
    
    func readFavoriteMovies(){
        self.favoriteFilmes.clear()
        favoriteFilmes.readFavorites()
    }

}

