//
//  SignUpViewController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/8/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
           
       //Round corners
       self.emailTextField.roundBorder(radius: 10)
       self.firstNameTextField.roundBorder(radius: 10)
       self.lastNameTextField.roundBorder(radius: 10)
       self.passwordTextField.roundBorder(radius: 10)
       self.signUpButton.roundBorder(radius: 10)
       
       //Set placeholders
       self.emailTextField.placeholder = "Insira seu email"
       self.firstNameTextField.placeholder = "Primeiro Nome"
       self.lastNameTextField.placeholder = "Sobrenome"
       self.passwordTextField.isSecureTextEntry = true
       self.passwordTextField.placeholder = "Insire sua senha"

   }
    
    @IBAction func signUpClicked() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty && !firstName.isEmpty && !lastName.isEmpty {
            if let user =  AuthVM().signUpUser(firstName: firstName, lastName: lastName, email: email, password: password) {
                USER = user
            } else {
                self.setAlert(title: "Nova conta erro!", message: "Um erro aconteceu quanto criando sua conta.")
                return
            }
            self.performSegue(withIdentifier: "goToHomeView", sender: self)
        } else {
            self.setAlert(title: "Nova conta erro!", message: "Preencha todos os campos")
            return
        }
    }
       
}
