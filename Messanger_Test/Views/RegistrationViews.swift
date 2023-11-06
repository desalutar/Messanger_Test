//
//  RegistrationViews.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 05.11.23.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func saveUser(with item: UserModel)
}

final class RegistrationViews: UIView {

    private let item: UserModel?
    private let appearance = Appearance()
    weak var delegate: RegistrationDelegate?
    
    init(item: UserModel? = nil) {
        self.item = item
        super.init(frame: .zero)
        registrationScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registrationScreen() {
        backgroundColor = ColorsConstants.backgroundView
        addSubview(userImage)
        addSubview(userName)
        addSubview(loginField)
        addSubview(passwordField)
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
        userImage.backgroundColor = ColorsConstants.colorRed
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    private lazy var userName : UITextField = {
        let userName = UITextField()
        userName.backgroundColor = ColorsConstants.colorWhite
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.placeholder = appearance.userNamePlaceholder
        userName.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
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
        saveButton.backgroundColor = ColorsConstants.saveButtonColor
        saveButton.addTarget(self, action: #selector(saveButtonHandler), for: .touchUpInside)
        return saveButton
    }()
    
    @objc func saveButtonHandler() {
        let item: UserModel
        item = UserModel(name: userName.text ?? .empty, login: loginField.text ?? .empty, password: passwordField.text ?? .empty, photo: userImage.image)
        delegate?.saveUser(with: item)
        print(item)
    }
    
    private lazy var loginField : UITextField = {
        let loginTextField = UITextField()
        loginTextField.backgroundColor = ColorsConstants.colorWhite
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = TextFieldConstant.loginPlaceholder
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
        passwordTextField.placeholder = TextFieldConstant.passwordPlaceHolder
        passwordTextField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        passwordTextField.layer.borderWidth = appearance.borderWidth
        passwordTextField.layer.cornerRadius = appearance.cornerRadius
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    // MARK: - NSLayoutConstraint
    
    enum UserImageLayoutConstant {
        static let userImageHeight: CGFloat = 150.0
        static let userImageWidth: CGFloat = 150.0
        static let userImageTop: CGFloat = 100.0
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
            loginField.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: UserLoginLayoutConstant.loginTextFieldTop),
            loginField.centerXAnchor.constraint(equalTo: userName.centerXAnchor),
            loginField.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            loginField.heightAnchor.constraint(equalToConstant: UserLoginLayoutConstant.loginTextFieldHeight)
        ])
    }
    
    enum UserPasswordLayoutConstant {
        static let passwordTextFieldTop: CGFloat = 20.0
        static let passwordTextFieldHeight: CGFloat = 30.0
    }
    private func layoutPassword() {
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: UserPasswordLayoutConstant.passwordTextFieldTop),
            passwordField.centerXAnchor.constraint(equalTo: loginField.centerXAnchor),
            passwordField.leadingAnchor.constraint(equalTo: loginField.leadingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: UserPasswordLayoutConstant.passwordTextFieldHeight)
        ])
    }
    
    enum SaveButtonConstant {
        static let saveButtonTop: CGFloat = 10
        
        static let saveButtonLeading = 100.0
    }
    private func layoutSaveButton() {
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: SaveButtonConstant.saveButtonTop),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: SaveButtonConstant.saveButtonLeading)
        ])
    }

}

extension RegistrationViews {
    struct Appearance {
        let userImageCornerRadius = 10.0
        let borderWidth = 0.5
        let cornerRadius = 5.0
        let userNamePlaceholder : String = "Enter_Name".localized
        let saveButtonTitle : String = "Save".localized
    }
    
    
    enum TextFieldConstant {
        static let loginPlaceholder : String = "Enter_Login".localized
        static let passwordPlaceHolder : String = "Enter_Password".localized
    }
    
    enum ColorsConstants {
        static let backgroundView = UIColor(red: 45/255, green: 47/255, blue: 57/255, alpha: 1)
        static let saveButtonColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
        static let registrationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
        static let textFieldLayerBorderColor: UIColor = .systemGray2
        static let colorRed: UIColor = .red
        static let colorWhite: UIColor = .white
    }
}
