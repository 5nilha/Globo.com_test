//
//  AuthVM.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/9/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation
import RNCryptor

struct AuthVM {
    
    init(){}
    
    private let tokenIdentifier = "TokenIdentifier"
    
    private func storeToken(token: String) {
        UserDefaults.standard.set(token, forKey: self.tokenIdentifier)
    }
    
    private func checkUserToken() -> String {
        let token = UserDefaults.standard.value(forKey: tokenIdentifier)
        return token as! String
    }
    
    func signInUser(email: String, password: String) -> UserViewModel? {
        //TODO: Create an user authentication
        let token = self.checkUserToken()
        
        // Check user auth. Then if find user auth, decrypt the auth password and compare aginst each other
        let authUser = UserViewModel(email: email)
    
        do {
            let decryptedPassword = try self.decryptPassword(encryptedMessage: authUser.password, encryptionKey: token)
            if password == decryptedPassword {
                return authUser
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func signUpUser(firstName: String, lastName: String, email: String, password: String) -> UserViewModel? {
        do {
            let newToken = try generateEncryptionKey(withPassword: password)
            let encryptedPassword = try encryptPassword(message: password, encryptionKey: newToken)
            self.storeToken(token: newToken)
            
            //TODO: Create an user authentication and sane on auth table
            //Creates a new user
            let newUser = UserViewModel(firstName: firstName, lastName: lastName, email: email, password: encryptedPassword)
            return newUser
        } catch {
            return nil
        }
    }
    
    func encryptPassword(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }

    func decryptPassword(encryptedMessage: String, encryptionKey: String) throws -> String {

        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }
    
    private func generateEncryptionKey(withPassword password:String) throws -> String {
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        return cipherData.base64EncodedString()
    }
}
