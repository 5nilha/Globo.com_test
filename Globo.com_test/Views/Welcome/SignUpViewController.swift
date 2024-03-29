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
        let dimensions = CGFloat(10.0)
           
       //Round corners
       self.emailTextField.roundBorder(radius: dimensions)
       self.firstNameTextField.roundBorder(radius: dimensions)
       self.lastNameTextField.roundBorder(radius: dimensions)
       self.passwordTextField.roundBorder(radius: dimensions)
       self.signUpButton.roundBorder(radius: dimensions)
       
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
            if let user =  AuthVM.auth.signUpUser(firstName: firstName, lastName: lastName, email: email, password: password) {
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
