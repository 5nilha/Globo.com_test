//
//  AuthVM.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation
import RNCryptor

class AuthVM {
    
    static func signInUser(email: String, password: String) -> UserViewModel? {
        //TODO: Create an user authentication
        
        //Reads the user
        let user = UserViewModel(email: email)
        return user
    }
    
    static func signUpUser(firstName: String, lastName: String, email: String, password: String) -> UserViewModel? {
        //TODO: Create an user authentication
        
        
        //Creates a new user
        let newUser = UserViewModel(firstName: firstName, lastName: lastName, email: email)
        return newUser
    }
    
    func encryptMessage(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }

    func decryptMessage(encryptedMessage: String, encryptionKey: String) throws -> String {

        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }
    
    func generateEncryptionKey(withPassword password:String) throws -> String {
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        return cipherData.base64EncodedString()
    }
}
