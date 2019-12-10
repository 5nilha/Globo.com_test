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
    private let password = Expression<String>("password")
    
    private override init() {
        super.init()
        do {
            if let connection = dbConnection {
                try connection.run(self.tblUsers.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.firstName)
                    table.column(self.lastName)
                    table.column(self.email)
                    table.column(self.password)
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
    func create(cfirstName: String, clastName: String, cemail: String, cpassword: String) -> Int64 {
        do {
            let insert = self.tblUsers.insert(firstName <- cfirstName, lastName <- clastName, email <- cemail, password <- cpassword)
             let id = try dbConnection!.run(insert)
             return id
        } catch {
            return -1
        }
    }
    
    func read(from email: String) -> User? {
        var users = [User]()
        
        do {
            for user in try dbConnection!.prepare("SELECT * FROM users WHERE email = '\(email)' ") {
                users.append(User(id: user[0] as! Int64,
                                  firstName: user[1] as! String,
                                  lastName: user[2] as! String,
                                  email: user[3]!  as! String,
                                  password: user[4] as! String))
            }
            return users.count > 0 ? users.first : nil
        } catch {
            print("Select failed")
            return nil
        }
    }
}
