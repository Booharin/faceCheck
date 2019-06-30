//
//  AuthViewController.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    var onLogin: (() -> Void)?
    
    private var environment: Environment {
        return EnvironmentImp.Debug()
    }
    
    lazy var authService: AuthService? = {
        let authService = AuthService(environment: environment)
        return authService
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    
    private func setViews() {
        loginTextField.attributedPlaceholder =
            NSAttributedString(string: "login".localized,
                               attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordTextField.attributedPlaceholder =
            NSAttributedString(string: "password".localized,
                               attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        enterButton.setTitle("sign_in".localized, for: .normal)
    }
    
    @IBAction func toEnter(_ sender: UIButton) {
        
        authService?.login(email: loginTextField.text ?? "",
                           password: passwordTextField.text ?? "") { [unowned self] token in
                            
                            DispatchQueue.main.async {
                                // temporary token treatment
                                guard let _ = token else { return }
                                self.onLogin?()
                            }
        }
    }
}
