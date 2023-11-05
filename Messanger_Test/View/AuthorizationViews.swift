//
//  AuthorizationViews.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 05.11.23.
//

import UIKit

protocol AuthorizationViewsDelegate: AnyObject {
    func switchToAuthorizationController()
}

final class AuthorizationViews: UIView {
    
    private let item : Model?
    private let appearance = Appearance()
    weak var delegate: AuthorizationViewsDelegate?
    
    init(item: Model? = nil) {
        self.item = item
        super.init(frame: .zero)
        authorizationScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func authorizationScreen() {
        backgroundColor = appearance.backgroundView
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
        layoutLoginTextField()
        layoutPasswordTextField()
        layoutSignInButton()
    }

    // MARK: - View Items
    private lazy var loginTextField : UITextField = {
        let loginTextField = UITextField()
        loginTextField.backgroundColor = appearance.colorWhite
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = appearance.loginPlaceholder
        loginTextField.layer.borderColor = appearance.textFieldLayerBorderColor.cgColor
        loginTextField.layer.borderWidth = appearance.borderWidth
        loginTextField.layer.cornerRadius = appearance.cornerRadius
        loginTextField.textAlignment = .center
        return loginTextField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = appearance.colorWhite
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = appearance.passwordPlaceHolder
        passwordTextField.layer.borderColor = appearance.textFieldLayerBorderColor.cgColor
        passwordTextField.layer.borderWidth = appearance.borderWidth
        passwordTextField.layer.cornerRadius = appearance.cornerRadius
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    
    private lazy var signInButton : UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle(appearance.singInButtonTitle, for: .normal)
        signInButton.backgroundColor = appearance.colorDarkGrey
        signInButton.layer.cornerRadius = appearance.cornerRadius
        signInButton.addTarget(self, action: #selector(signInButtonHandler), for: .touchUpInside)
        return signInButton
    }()
    
    @objc func signInButtonHandler() {
        print("Добавить метод для перехода в TableVIew")
    }
    
    // MARK: - Layouts

    enum LoginLayoutConstant {
        static let loginTextFieldLeading: CGFloat = 40.0
        static let loginTextFieldTrailing: CGFloat = -40.0
        static let loginTextFieldHeight: CGFloat = 30.0
        static let loginTextFieldBottom: CGFloat = -235.0
    }
    private func layoutLoginTextField() {
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LoginLayoutConstant.loginTextFieldLeading),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LoginLayoutConstant.loginTextFieldTrailing),
            loginTextField.heightAnchor.constraint(equalToConstant: LoginLayoutConstant.loginTextFieldHeight),
            loginTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: LoginLayoutConstant.loginTextFieldBottom)
        ])
    }
    
    enum PasswordLayoutConstant {
        static let passwordLeading: CGFloat = 40.0
        static let passwordTrailing: CGFloat = -40.0
        static let passwordHeight: CGFloat = 30.0
        static let passwordTop: CGFloat = 10.0
    }
    private func layoutPasswordTextField() {
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PasswordLayoutConstant.passwordLeading),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: PasswordLayoutConstant.passwordTrailing),
            passwordTextField.heightAnchor.constraint(equalToConstant: PasswordLayoutConstant.passwordHeight),
            passwordTextField.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,
                                                   constant: PasswordLayoutConstant.passwordTop)
        ])
    }
    
    enum SignInLayoutConstant {
        static let signInLeading: CGFloat = 95.0
        static let signInTop: CGFloat = 10.0
    }
    private func layoutSignInButton() {
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SignInLayoutConstant.signInLeading),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: SignInLayoutConstant.signInTop)
        ])
    }
    
}

extension AuthorizationViews {
    struct Appearance {
        
        let backgroundView = UIColor(red: 45/255, green: 47/255, blue: 57/255, alpha: 1)
        let colorWhite: UIColor = .white
        
        let passwordPlaceHolder : String = "Enter_Password".localized
        let singInButtonTitle : String = "Enter".localized
        let loginPlaceholder : String = "Enter_Login".localized
        
        let textFieldLayerBorderColor: UIColor = .systemGray2
        let borderWidth = 0.5
        let cornerRadius = 5.0
        
        let registrationScreenButtonTitle: String = "Sign_In".localized
        
        let colorDarkGrey: UIColor = .darkGray
        
    }
}


