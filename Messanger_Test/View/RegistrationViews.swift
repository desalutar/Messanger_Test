//
//  RegistrationViews.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 05.11.23.
//

import UIKit

final class RegistrationViews: UIView {

    private let item: Model?
    private let appearance = Appearance()
    
    init(item: Model? = nil) {
        self.item = item
        super.init(frame: .zero)
        registrationScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registrationScreen() {
        backgroundColor = colorsConstants.backgroundView
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
    
    // MARK: - View Items
    private lazy var userImage : UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.cornerRadius = appearance.userImageCornerRadius
        userImage.backgroundColor = colorsConstants.colorRed
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    private lazy var userName : UITextField = {
        let userName = UITextField()
        userName.backgroundColor = colorsConstants.colorWhite
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.placeholder = appearance.userNamePlaceholder
        userName.layer.borderColor = colorsConstants.textFieldLayerBorderColor.cgColor
        userName.layer.borderWidth = appearance.borderWidth
        userName.layer.cornerRadius = appearance.cornerRadius
        userName.textAlignment = .center
        return userName
    }()
    private lazy var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle(saveButtonConstant.saveButtonTitle, for: .normal)
        saveButton.layer.cornerRadius = appearance.cornerRadius
        saveButton.backgroundColor = colorsConstants.authorizationBackgroundColor
        return saveButton
    }()
    
    private lazy var loginTextField : UITextField = {
        let loginTextField = UITextField()
        loginTextField.backgroundColor = colorsConstants.colorWhite
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = textFieldConstant.loginPlaceholder
        loginTextField.layer.borderColor = colorsConstants.textFieldLayerBorderColor.cgColor
        loginTextField.layer.borderWidth = appearance.borderWidth
        loginTextField.layer.cornerRadius = appearance.cornerRadius
        loginTextField.textAlignment = .center
        return loginTextField
    }()
    
    private lazy var passwordTextField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = colorsConstants.colorWhite
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = textFieldConstant.passwordPlaceHolder
        passwordTextField.layer.borderColor = colorsConstants.textFieldLayerBorderColor.cgColor
        passwordTextField.layer.borderWidth = appearance.borderWidth
        passwordTextField.layer.cornerRadius = appearance.cornerRadius
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    
    enum UserImageLayoutConstant {
        static let userImageHeight: CGFloat = 100.0
        static let userImageWidth: CGFloat = 100.0
        static let userImageTop: CGFloat = 50.0
    }
    private func layoutUserImage() {
        NSLayoutConstraint.activate([
            userImage.heightAnchor.constraint(equalToConstant: UserImageLayoutConstant.userImageHeight),
            userImage.widthAnchor.constraint(equalToConstant: UserImageLayoutConstant.userImageWidth),
            userImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: UserImageLayoutConstant.userImageTop)
        ])
    }
    
    enum UserNameLayoutConstant {
        static let userNameTop: CGFloat = 120.0
        static let userNameLeading: CGFloat = 50.0
        static let userNameHeight: CGFloat = 30.0
    }
    private func layoutUserName() {
        NSLayoutConstraint.activate([
            userName.centerXAnchor.constraint(equalTo: userImage.centerXAnchor),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: UserNameLayoutConstant.userNameTop),
            userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UserNameLayoutConstant.userNameLeading),
            userName.heightAnchor.constraint(equalToConstant: UserNameLayoutConstant.userNameHeight)
        ])
    }
    
    enum UserLoginLayoutConstant {
        static let loginTextFieldTop: CGFloat = 20.0
        static let loginTextFieldHeight: CGFloat = 30.0
    }
    private func layoutUserLogin() {
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: UserLoginLayoutConstant.loginTextFieldTop),
            loginTextField.centerXAnchor.constraint(equalTo: userName.centerXAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: UserLoginLayoutConstant.loginTextFieldHeight)
        ])
    }
    
    enum UserPasswordLayoutConstant {
        static let passwordTextFieldTop: CGFloat = 20.0
        static let passwordTextFieldHeight: CGFloat = 30.0
    }
    private func layoutPassword() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: UserPasswordLayoutConstant.passwordTextFieldTop),
            passwordTextField.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: UserPasswordLayoutConstant.passwordTextFieldHeight)
        ])
    }
    
    enum SaveButtonLayoutConstant {
        static let saveButtonTop: CGFloat = 10
    }
    private func layoutSaveButton() {
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: SaveButtonLayoutConstant.saveButtonTop),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: saveButtonConstant.saveButtonLeading)
        ])
    }

}

extension RegistrationViews {
    struct Appearance {
        let userImageCornerRadius = 50.0
        let borderWidth = 0.5
        let cornerRadius = 5.0
        let userNamePlaceholder : String = "Enter_Name".localized
    }
    
    enum saveButtonConstant {
        static let saveButtonTitle : String = "Save".localized
        static let saveButtonLeading = 100.0
    }
    
    enum textFieldConstant {
        static let loginPlaceholder : String = "Enter_Login".localized
        static let passwordPlaceHolder : String = "Enter_Password".localized
    }
    
    enum colorsConstants {
        static let backgroundView = UIColor(red: 45/255, green: 47/255, blue: 57/255, alpha: 1)
        static let authorizationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0.5)
        static let registrationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
        static let textFieldLayerBorderColor: UIColor = .systemGray2
        static let colorRed: UIColor = .red
        static let colorWhite: UIColor = .white
    }
}
