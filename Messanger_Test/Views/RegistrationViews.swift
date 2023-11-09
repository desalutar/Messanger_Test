//
//  RegistrationViews.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 05.11.23.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func saveUserModel(with item: UserModel)
}

final class RegistrationViews: UIView {

    private let item: UserModel?
    private let appearance = Appearance()
    weak var delegate: RegistrationDelegate?
    
    init(item: UserModel? = nil) {
        self.item = item
        super.init(frame: .zero)
        setViewItems()
        hideKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewItems() {
        backgroundColor = ColorsConstants.backgroundView
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        
        layoutScrollView()
        layoutContentView()
        layoutMainStackView()
        layoutBottomStackView()
        layoutUserImage()
        layoutUserLogin()
        layoutUserName()
        layoutPassword()
    }
    
    private func hideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if contentView.frame.origin.y == 0 {
                contentView.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if contentView.frame.origin.y != 0 {
            contentView.frame.origin.y = 0
        }
    }
    
    // MARK: - View Items
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView : UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userImage, bottomStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = MainStackLayoutConstant.spacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let bottomStackView = UIStackView(arrangedSubviews: [loginField, userName, passwordField, saveButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fill
        bottomStackView.spacing = appearance.spacing
        return bottomStackView
    }()

    private lazy var userImage : UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.cornerRadius = appearance.userImageCornerRadius
        userImage.backgroundColor = ColorsConstants.colorRed
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
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
        delegate?.saveUserModel(with: item)
        print(item)
    }

    
    // MARK: - NSLayoutConstraint
    
    private func layoutScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func layoutContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    enum MainStackLayoutConstant {
        static let spacing: CGFloat = 70.0
        static let topAnchor: CGFloat = 50.0
        static let leadingAnchor: CGFloat = 40
        static let trailingAnchor: CGFloat = -40
        static let bottomAnchor: CGFloat = -50.0
    }
    private func layoutMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, 
                                               constant: MainStackLayoutConstant.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, 
                                                   constant: MainStackLayoutConstant.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, 
                                                    constant: MainStackLayoutConstant.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, 
                                                  constant: MainStackLayoutConstant.bottomAnchor),
        ])
    }
    
    private func layoutBottomStackView() {
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func layoutUserImage() {
        NSLayoutConstraint.activate([
            userImage.heightAnchor.constraint(equalToConstant: UserImageLayoutConstant.height),
            userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor,
                                             multiplier: UserImageLayoutConstant.width)
        ])
    }
    
    private func layoutUserName() {
        NSLayoutConstraint.activate([
            userName.heightAnchor.constraint(equalToConstant: appearance.userNameLayoutHeight)
        ])
    }
    
    private func layoutUserLogin() {
        NSLayoutConstraint.activate([
            loginField.heightAnchor.constraint(equalToConstant: appearance.userLoginLayoutHeight),
        ])
    }
    
    private func layoutPassword() {
        NSLayoutConstraint.activate([
            passwordField.heightAnchor.constraint(equalToConstant: appearance.userPasswordLayoutHeight)
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
        let spacing: CGFloat = 10.0
        let userNameLayoutHeight: CGFloat = 44.0
        let userPasswordLayoutHeight: CGFloat = 44.0
        let userLoginLayoutHeight: CGFloat = 44
    }
    
    enum UserImageLayoutConstant {
        static let height: CGFloat = 120.0
        static let width: CGFloat = 1.0
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
