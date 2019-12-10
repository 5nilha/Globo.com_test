//
//  LoginViewController.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/8/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    /* setupView will setup the outlets on the view */
    private func setupView() {
        //Round corners
        self.emailTextField.roundBorder(radius: 8)
        self.passwordTextField.roundBorder(radius: 8)
        self.signInButton.roundBorder(radius: 10)
        self.SignUpButton.roundBorder(radius: 10)
        
        //Set placeholders
        self.emailTextField.placeholder = "Insira seu email"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.placeholder = "Insire sua senha"
    }
    
    
    /* setLoading will start the spinner and se textfields and buttons to:
    * disable if is loading
    * enable if is not loading
    */
    private func setLoading(_ loading: Bool) {
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        self.emailTextField.isEnabled = !loading
        self.passwordTextField.isEnabled = !loading
        self.signInButton.isEnabled = !loading
        self.SignUpButton.isEnabled = !loading
    }
    
    /* sigIn will try to authenticate and return the user data
     * The method return the userViewModel in the completion handler
     * If the completion returns an error, the user is logged out and the spinner stop loading
    */
    @IBAction func signIn() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !email.isEmpty && !password.isEmpty {
            self.setLoading(true)
            if let user = AuthVM().signInUser(email: email, password: password) {
                USER = user
            } else {
                self.setAlert(title: "Error de Accesso", message: "Sua senha esta errada ou a conta não existe")
            }
            
            self.performSegue(withIdentifier: "goToHomeView", sender: self)
        } else {
            self.setAlert(title: "Error de Accesso", message: "Preencha todos os campos")
            return
        }
        
    }
    
    @IBAction func SignUpButtonClicked() {
        self.performSegue(withIdentifier: "goToRegistrationSegue", sender: nil)
    }
}
