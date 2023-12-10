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
    weak var delegate: AuthorizationViewsDelegate?
    
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
        layoutLoginTextField()
        layoutPasswordTextField()
        layoutSignInButton()
    }
    
    private func hideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), 
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), 
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if contentView.frame.origin.y == 0 {
                contentView.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if contentView.frame.origin.y != 0 {
            contentView.frame.origin.y = 0
        }
    }

    // MARK: - View Items
    private lazy var scrollView : UIScrollView = {
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
        let stackView = UIStackView(arrangedSubviews: [loginField, passwordField, signInButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var loginField : UITextField = {
        let loginTextField = UITextField()
        loginTextField.backgroundColor = ColorsConstants.colorWhite
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = LocalizedStringsConstant.loginPlaceholder
        loginTextField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        loginTextField.layer.borderWidth = Appearance.borderWidth
        loginTextField.layer.cornerRadius = Appearance.cornerRadius
        loginTextField.textAlignment = .center
        return loginTextField
    }()
    
    private lazy var passwordField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = ColorsConstants.colorWhite
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = LocalizedStringsConstant.passwordPlaceHolder
        passwordTextField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        passwordTextField.layer.borderWidth = Appearance.borderWidth
        passwordTextField.layer.cornerRadius = Appearance.cornerRadius
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    
    private lazy var signInButton : UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle(LocalizedStringsConstant.singInButtonTitle, for: .normal)
        signInButton.backgroundColor = ColorsConstants.signInButtonColor
        signInButton.layer.cornerRadius = Appearance.cornerRadius
        signInButton.addTarget(self, action: #selector(signInButtonHandler), for: .touchUpInside)
        return signInButton
    }()
    
    @objc func signInButtonHandler() {
        print("Добавить метод для перехода в TableVIew")
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
    
    enum MainStackConstants {
        static let mainStackTop: CGFloat = 400.0
        static let mainStackLeading: CGFloat = 30.0
        static let mainStackTrailing: CGFloat = -30.0
        static let mainStackBottom: CGFloat = -30.0
    }
    private func layoutMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: MainStackConstants.mainStackTop),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: MainStackConstants.mainStackLeading),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: MainStackConstants.mainStackTrailing),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: MainStackConstants.mainStackBottom),
        ])
    }
    
    
    enum LoginLayoutConstant {
        static let loginTextFieldWidth: CGFloat = 280.0
        static let loginTextFieldHeight: CGFloat = 44.0
    }
    private func layoutLoginTextField() {
        NSLayoutConstraint.activate([
            loginField.heightAnchor.constraint(equalToConstant: LoginLayoutConstant.loginTextFieldHeight),
            loginField.widthAnchor.constraint(equalToConstant: LoginLayoutConstant.loginTextFieldWidth)
        ])
    }
    
    enum PasswordLayoutConstant {
        static let passwordHeight: CGFloat = 44.0
        static let passwordWidth: CGFloat = 280
    }
    private func layoutPasswordTextField() {
        NSLayoutConstraint.activate([
            passwordField.heightAnchor.constraint(equalToConstant: PasswordLayoutConstant.passwordHeight),
            passwordField.widthAnchor.constraint(equalToConstant: PasswordLayoutConstant.passwordWidth)
        ])
    }
    
    enum SignInLayoutConstant {
        static let signInWidth: CGFloat = 280.0
        static let signInHeight: CGFloat = 44.0
    }
    private func layoutSignInButton() {
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: SignInLayoutConstant.signInWidth),
            signInButton.heightAnchor.constraint(equalToConstant: SignInLayoutConstant.signInHeight)
        ])
    }
}

extension AuthorizationViews {
    struct Appearance {
        static let borderWidth = 0.5
        static let cornerRadius = 5.0
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


