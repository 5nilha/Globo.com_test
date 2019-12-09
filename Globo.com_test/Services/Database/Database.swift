//
//  Database.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation
import SQLite

class Database {
    
    public let dbConnection: Connection?
    private let databaseFileName = "Globo.com_test.sqlite"
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                            in: .userDomainMask,
                                                            appropriateFor: nil,
                                                            create: true)
            let fileURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            dbConnection = try Connection(fileURL.path)
        }catch {
            dbConnection = nil
            print("Cannot Connect to database. Error: \(error.localizedDescription)")
        }
    }
}
