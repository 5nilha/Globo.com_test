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
    private init(){}
    static let auth = AuthVM()
    
    private let tokenIdentifier = "TokenIdentifier"
    
    func signInUser(email: String, password: String) -> UserViewModel? {
    
        guard let token: String = self.checkUserToken() else { return nil }
        
        // Check user auth. Then if finds user auth, decrypt the auth password and compare against each other
        guard let authUser = UserViewModel(email: email) else { return nil }
        
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
            let newToken: String? = try generateToken(withPassword: password)
            guard let token = newToken else { return nil }
            let encryptedPassword = try encryptPassword(message: password, encryptionKey: token)

            //Creates a new user
            let newUser = UserViewModel(firstName: firstName, lastName: lastName, email: email, password: encryptedPassword)
            return newUser
        } catch {
            return nil
        }
    }
    
    func signOut() {
        USER = nil
    }
    
    private func checkUserToken() -> String? {
        //Checks for the default token
        let token = UserDefaults.standard.value(forKey: tokenIdentifier)
        if let token = token as? String {
            return token
        } else {
            return nil
        }
    }
    
    
    private func encryptPassword(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }

    private func decryptPassword(encryptedMessage: String, encryptionKey: String) throws -> String {

        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }
    
    private func generateToken(withPassword password:String) throws -> String {
        let randomData = RNCryptor.randomData(ofLength: 32)
        let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
        let newToken = cipherData.base64EncodedString()
        
        // Checks if the default token already exists. If not, creates a new token
        guard let defaultToken: String = UserDefaults.standard.value(forKey: tokenIdentifier) as? String else {
            UserDefaults.standard.set(newToken, forKey: self.tokenIdentifier)
            return newToken
        }
        return defaultToken
    }
}
