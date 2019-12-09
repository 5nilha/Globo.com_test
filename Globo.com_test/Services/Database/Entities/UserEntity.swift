//
//  UserEntity.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation
import SQLite

class UserEntity: Database {
    static let shared = UserEntity()
    
    //Daatabase Table
    private let tblUsers = Table("users")
    
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String?>("first_name")
    private let lastName = Expression<String?>("last_name")
    private let email = Expression<String>("email")
    
    private override init() {
        super.init()
        do {
            if let connection = dbConnection {
                try connection.run(self.tblUsers.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.firstName)
                    table.column(self.lastName)
                    table.column(email)
                }))
                print("users table successfully created")
            } else {
                print("users table creation failed")
            }
        } catch {
            print("users table creation failed. Error: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: -> CRUD Operations
    
    // INSERT INTO users
    func create(cfirstName: String, clastName: String, cemail: String) -> Int64 {
        do {
            let insert = self.tblUsers.insert(firstName <- cfirstName, lastName <- clastName, email <- cemail)
             let id = try dbConnection!.run(insert)
             return id
        } catch {
            return -1
        }
    }
    
    // SELECT * FROM "users"
    func read() -> [User] {
        var users = [User]()
        
        do {
            for user in try dbConnection!.prepare(self.tblUsers) {
                users.append(User(id: user[id],
                                  firstName: user[firstName]!,
                                  lastName: user[lastName]!,
                                  email: user[email]))
            }
        } catch {
            print("Select failed")
        }
        
        return users
    }
}
