//
//  ViewItems.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

protocol ViewItemsDelegate: AnyObject {
    func switchToRegistrationController()
    func switchToAuthorizationController()
}

final class ViewItems : UIView {
    
    enum ViewType {
        case startScreen
        case authorizationScreen
        case registrationScreen
    }
    
    weak var delegate: ViewItemsDelegate?
    
    private let item : Model?
    private let viewType : ViewType
    private let appearance = Appearance()
    
    init(viewType: ViewType, item: Model? = nil) {
        self.viewType = viewType
        self.item = item
        super.init(frame: .zero)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        switch viewType {
        case .startScreen:
            // тут передадим функцию которая будет хранить стартовый экран
            startScreen()
        case .authorizationScreen:
            // тут передадим функцию которая будет хранить экран для входа в систему
            authorizationScreen()
        case .registrationScreen:
            // тут передадим функцию которая будет хранить экран регистрации
            registrationScreen()
        }
    }
    
    private func startScreen() {
        backgroundColor = appearance.startScreenBackgroundColor
        addSubview(registrationScreenButton)
        addSubview(authorizationScreenButton)
        layoutAuthorizationScreenButton()
        layoutRegistrationScreenButton()
    }
    
    private func authorizationScreen() {
        backgroundColor = appearance.startScreenBackgroundColor
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(authorizationScreenButton)
        layoutLoginTextField()
        layoutPasswordTextField()
        layoutSignInButton()
    }
    
    private func registrationScreen() {
        backgroundColor = appearance.startScreenBackgroundColor
        addSubview(userImage)
        addSubview(userName)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(saveButton)
        layoutUserImage()
        layoutUserName()
        layoutUserLogin()
        layoutPassword()
        layoutSaveButton()
    }
    
    // MARK: - UI Items
    private lazy var registrationScreenButton : UIButton = {
        let registrationButton = UIButton()
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle(appearance.authorizationScreenButtonTitle, for: .normal)
        registrationButton.layer.cornerRadius = appearance.cornerRadius
        registrationButton.backgroundColor = appearance.authorizationBackgroundColor
        registrationButton.addTarget(self, action: #selector(registrationHandler),
                                     for: .touchUpInside)
        return registrationButton
    }()
    
    @objc func registrationHandler() {
        delegate?.switchToRegistrationController()
        print("registration")
    }
    
    private lazy var authorizationScreenButton : UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle(appearance.registrationScreenButtonTitle, for: .normal)
        signInButton.backgroundColor = appearance.registrationBackgroundColor
        signInButton.layer.cornerRadius = appearance.cornerRadius
        signInButton.addTarget(self, action: #selector(signInHandler), for: .touchUpInside)
        return signInButton
    }()
    
    @objc func signInHandler() {
        delegate?.switchToAuthorizationController()
    }
    
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
        return signInButton
    }()
    
    private lazy var userImage : UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.cornerRadius = appearance.userImageCornerRadius
        userImage.backgroundColor = appearance.colorRed
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    private lazy var userName : UITextField = {
        let userName = UITextField()
        userName.backgroundColor = appearance.colorWhite
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.placeholder = appearance.userNamePlaceholder
        userName.layer.borderColor = appearance.textFieldLayerBorderColor.cgColor
        userName.layer.borderWidth = appearance.borderWidth
        userName.layer.cornerRadius = appearance.cornerRadius
        userName.textAlignment = .center
        return userName
    }()
    private lazy var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle(appearance.saveButtonTitle, for: .normal)
        saveButton.layer.cornerRadius = appearance.cornerRadius
        saveButton.backgroundColor = appearance.authorizationBackgroundColor
        return saveButton
    }()
    
    
    // MARK: - NSLayoutConstraint
    
    private func layoutAuthorizationScreenButton() {
        NSLayoutConstraint.activate([
            registrationScreenButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: appearance.authorizationLeadingAnchor),
            
            registrationScreenButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: appearance.authorizationTrailingAnchor),
            
            registrationScreenButton.heightAnchor.constraint(equalToConstant: appearance.authorizationHeightAnchor),
            
            registrationScreenButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: appearance.authorizationBottomAnchor)
        ])
    }
    private func layoutRegistrationScreenButton() {
        NSLayoutConstraint.activate([
            authorizationScreenButton.centerXAnchor.constraint(equalTo: registrationScreenButton.centerXAnchor),
            
            authorizationScreenButton.widthAnchor.constraint(equalToConstant: appearance.registrationWidthAnchor),
            
            authorizationScreenButton.topAnchor.constraint(
                equalTo: registrationScreenButton.bottomAnchor,
                constant: appearance.registrationBottomAnchor)
        ])
        
    }
    
    
    private func layoutLoginTextField() {
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.0),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40.0),
            loginTextField.heightAnchor.constraint(equalToConstant: 30.0),
            loginTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -235)
        ])
    }
    private func layoutPasswordTextField() {
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.0),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30.0),
            passwordTextField.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,
                                                   constant: 10.0)
        ])
    }
    private func layoutSignInButton() {
        NSLayoutConstraint.activate([
            authorizationScreenButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            authorizationScreenButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10)
        ])
    }
    
    
    private func layoutUserImage() {
        NSLayoutConstraint.activate([
            userImage.heightAnchor.constraint(equalToConstant: 100),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ])
    }
    private func layoutUserName() {
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: userImage.centerXAnchor),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 120),
            userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            userName.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func layoutUserLogin() {
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: userName.centerXAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func layoutPassword() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func layoutSaveButton() {
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: appearance.saveButtonLeading)
        ])
    }
}

private extension ViewItems {
    struct Appearance {
        let startScreenBackgroundColor = UIColor(red: 45/255, green: 47/255, blue: 57/255, alpha: 1)
        
        let authorizationScreenButtonTitle: String = "Registration".localized
        let registrationScreenButtonTitle: String = "Sign_In".localized
        
        let authorizationLeadingAnchor = 60.0
        let authorizationTrailingAnchor = -60.0
        let authorizationHeightAnchor = 40.0
        let authorizationBottomAnchor = -90.0
        
        let registrationWidthAnchor = 70.0
        let registrationBottomAnchor = 10.0
        
        let cornerRadius = 5.0
        let borderWidth = 0.5
        let registrationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
        let authorizationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0.5)
        
        let textFieldLayerBorderColor: UIColor = .systemGray2
        let colorWhite: UIColor = .white
        let colorRed: UIColor = .red
        let colorDarkGrey: UIColor = .darkGray
        let userImageCornerRadius = 50.0
        let saveButtonLeading = 100.0
        let loginPlaceholder : String = "Enter_Login".localized
        let passwordPlaceHolder : String = "Enter_Password".localized
        let singInButtonTitle : String = "Enter".localized
        let userNamePlaceholder : String = "Enter_Name".localized
        let saveButtonTitle : String = "Save".localized
    }
}
