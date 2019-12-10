//
//  User.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/8/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

struct User {
    public private (set) var id: Int64!
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    init(id: Int64, firstName: String, lastName: String , email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    //MARK: -> CRUD
    mutating func create() {
        let id = UserEntity.shared.create(cfirstName: self.firstName, clastName: self.lastName, cemail: self.email, cpassword: self.password)
        self.id = id
    }
    
    static func read(email: String) -> User? {
        let user = UserEntity.shared.read(from: email)
        return user
    }
}
