//
//  UserViewModel.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/8/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

var USER: UserViewModel!

struct UserViewModel {
    
    private var user: User?
    public private (set) lazy var favoriteFilmes = FilmesListViewModel()
    
    init?(email: String) {
        let user =  User.read(email: email)
        
        if user != nil{
            self.user = user
            favoriteFilmes.readFavorites(userId: user!.id)
        }
        else {
            return nil
        }
    }
    
    init(firstName: String, lastName: String, email: String, password: String) {
        self.user = User(id: -1, firstName: firstName, lastName: lastName, email: email, password: password)
        user!.create()
        self.favoriteFilmes = FilmesListViewModel()
    }
    
    var id: Int64 {
        return self.user!.id!
    }
    
    var firstName: String {
        return self.user!.firstName
    }
    
    var lastName: String {
        return self.user!.lastName
    }
    
    var fullName: String {
        return "\(String(describing: self.user!.firstName)) \(String(describing: self.user!.lastName))"
    }
    
    var email: String {
        return self.user!.email
    }
    
    var password: String {
        return self.user!.password
    }
    
    mutating func readFavoriteMovies(){
        self.favoriteFilmes.clear()
        favoriteFilmes.readFavorites(userId: self.user!.id)
    }
    
    func deleteAccount() {
        self.user?.delete()
    }

}


