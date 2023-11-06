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
    
    private let item : UserModel?
    private let appearance = Appearance()
    weak var delegate: AuthorizationViewsDelegate?
    
    init(item: UserModel? = nil) {
        self.item = item
        super.init(frame: .zero)
        authorizationScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func authorizationScreen() {
        backgroundColor = ColorsConstants.backgroundView
        addSubview(loginField)
        addSubview(passwordField)
        addSubview(signInButton)
        layoutLoginTextField()
        layoutPasswordTextField()
        layoutSignInButton()
    }

    // MARK: - View Items
    private lazy var loginField : UITextField = {
        let loginTextField = UITextField()
        loginTextField.backgroundColor = ColorsConstants.colorWhite
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = LocalizedStringsConstant.loginPlaceholder
        loginTextField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        loginTextField.layer.borderWidth = appearance.borderWidth
        loginTextField.layer.cornerRadius = appearance.cornerRadius
        loginTextField.textAlignment = .center
        return loginTextField
    }()
    
    private lazy var passwordField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = ColorsConstants.colorWhite
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = LocalizedStringsConstant.passwordPlaceHolder
        passwordTextField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        passwordTextField.layer.borderWidth = appearance.borderWidth
        passwordTextField.layer.cornerRadius = appearance.cornerRadius
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    
    private lazy var signInButton : UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle(LocalizedStringsConstant.singInButtonTitle, for: .normal)
        signInButton.backgroundColor = ColorsConstants.signInButtonColor
        signInButton.layer.cornerRadius = appearance.cornerRadius
        signInButton.addTarget(self, action: #selector(signInButtonHandler), for: .touchUpInside)
        return signInButton
    }()
    
    @objc func signInButtonHandler() {
        print("Добавить метод для перехода в TableVIew")
    }
    
    // MARK: - NSLayoutConstraint

    enum LoginLayoutConstant {
        static let loginTextFieldLeading: CGFloat = 40.0
        static let loginTextFieldTrailing: CGFloat = -40.0
        static let loginTextFieldHeight: CGFloat = 30.0
        static let loginTextFieldBottom: CGFloat = -235.0
    }
    private func layoutLoginTextField() {
        NSLayoutConstraint.activate([
            loginField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LoginLayoutConstant.loginTextFieldLeading),
            loginField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: LoginLayoutConstant.loginTextFieldTrailing),
            loginField.heightAnchor.constraint(equalToConstant: LoginLayoutConstant.loginTextFieldHeight),
            loginField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: LoginLayoutConstant.loginTextFieldBottom)
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
            passwordField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PasswordLayoutConstant.passwordLeading),
            passwordField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: PasswordLayoutConstant.passwordTrailing),
            passwordField.heightAnchor.constraint(equalToConstant: PasswordLayoutConstant.passwordHeight),
            passwordField.centerXAnchor.constraint(equalTo: loginField.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor,
                                                   constant: PasswordLayoutConstant.passwordTop)
        ])
    }
    
    enum SignInLayoutConstant {
        static let signInLeading: CGFloat = 95.0
        static let signInTop: CGFloat = 10.0
    }
    private func layoutSignInButton() {
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: SignInLayoutConstant.signInLeading),
            signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: SignInLayoutConstant.signInTop)
        ])
    }
}

extension AuthorizationViews {
    struct Appearance {
        let borderWidth = 0.5
        let cornerRadius = 5.0
    }
    
    enum ColorsConstants {
        static let backgroundView = UIColor(red: 45/255, green: 47/255, blue: 57/255, alpha: 1)
        static let signInButtonColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
        static let colorWhite: UIColor = .white
        static let textFieldLayerBorderColor: UIColor = .systemGray2
    }
    
    enum LocalizedStringsConstant {
        static let passwordPlaceHolder : String = "Enter_Password".localized
        static let singInButtonTitle : String = "Enter".localized
        static let loginPlaceholder : String = "Enter_Login".localized
        static let registrationScreenButtonTitle: String = "Sign_In".localized
    }
}


