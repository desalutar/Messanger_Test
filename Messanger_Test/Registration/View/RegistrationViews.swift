//
//  RegistrationViews.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 05.11.23.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func saveUserModel(with item: UserModel)
    func registrationUser(with email: String, password: String, name: String)
    
}

final class RegistrationViews: UIView {

    private let item: UserModel?
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
        layoutErrorLabel()
        layoutPassword()
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
        let bottomStackView = UIStackView(arrangedSubviews: [emailField, userName, 
                                                             passwordField, errorLabel, saveButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fill
        bottomStackView.spacing = Appearance.spacing
        return bottomStackView
    }()

    private lazy var userImage : UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.cornerRadius = Appearance.userImageCornerRadius
        userImage.backgroundColor = ColorsConstants.colorRed
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        return userImage
    }()
    
    private lazy var userName : UITextField = {
        let userName = UITextField()
        userName.backgroundColor = ColorsConstants.colorWhite
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.placeholder = Appearance.userNamePlaceholder
        userName.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        userName.layer.borderWidth = Appearance.borderWidth
        userName.layer.cornerRadius = Appearance.cornerRadius
        userName.textAlignment = .center
        return userName
    }()
    
    private lazy var emailField : UITextField = {
        let emailField = UITextField()
        emailField.backgroundColor = ColorsConstants.colorWhite
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.placeholder = TextFieldConstant.loginPlaceholder
        emailField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        emailField.layer.borderWidth = Appearance.borderWidth
        emailField.layer.cornerRadius = Appearance.cornerRadius
        emailField.textAlignment = .center
        return emailField
    }()
    
    private lazy var passwordField : UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = ColorsConstants.colorWhite
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = TextFieldConstant.passwordPlaceHolder
        passwordTextField.layer.borderColor = ColorsConstants.textFieldLayerBorderColor.cgColor
        passwordTextField.layer.borderWidth = Appearance.borderWidth
        passwordTextField.layer.cornerRadius = Appearance.cornerRadius
        passwordTextField.textAlignment = .center
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private lazy var errorLabel : UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        errorLabel.text = Appearance.errorFieldText
        return errorLabel
    }()
    
    private lazy var saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle(Appearance.saveButtonTitle, for: .normal)
        saveButton.layer.cornerRadius = Appearance.cornerRadius
        saveButton.backgroundColor = ColorsConstants.saveButtonColor
        saveButton.addTarget(self, action: #selector(saveButtonHandler), for: .touchUpInside)
        return saveButton
    }()
    
    @objc func saveButtonHandler() {
        if validationField()  {
            errorLabel.isHidden = true
            delegate?.registrationUser(with: emailField.text!, password: passwordField.text!, name: userName.text!)
        } else {
            errorLabel.isHidden = false
        }
    }
}

extension RegistrationViews {
    
    func validationField() -> Bool {
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: emailField.text ?? .empty)
        let isValidUserName = isValidUserName(userName: userName.text ?? .empty)
        let isValidUserPassword = isValidPassword(passwordString: passwordField.text ?? .empty)
        
        if isEmailAddressValid && isValidUserName && isValidUserPassword {
            return true
        } else {
            return false
        }
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegex)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 { returnValue = false }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isValidUserName(userName: String) -> Bool {
        var returnValue = true
        let nameRegex = "^[a-zA-Z_]{4,13}$"
        
        do {
            let regex = try NSRegularExpression(pattern: nameRegex)
            let nsString = userName as NSString
            let results = regex.matches(in: userName, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 { returnValue = false }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return returnValue
    }
    
    func isValidPassword(passwordString: String) -> Bool {
        var resultValue = true
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        do {
            let regex = try NSRegularExpression(pattern: passwordRegex)
            let nsString = passwordString as NSString
            let results = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 { resultValue = false}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            resultValue = false
        }
        
        return resultValue
    }
    
}

extension RegistrationViews {
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
            userName.heightAnchor.constraint(equalToConstant: Appearance.userNameLayoutHeight)
        ])
    }
    
    private func layoutUserLogin() {
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: Appearance.userLoginLayoutHeight),
        ])
    }
    
    private func layoutErrorLabel() {
        NSLayoutConstraint.activate([
            errorLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func layoutPassword() {
        NSLayoutConstraint.activate([
            passwordField.heightAnchor.constraint(equalToConstant: Appearance.userPasswordLayoutHeight)
        ])
    }
}
extension RegistrationViews {
    struct Appearance {
        static let userImageCornerRadius = 10.0
        static let borderWidth = 0.5
        static let cornerRadius = 5.0
        static let userNamePlaceholder : String = "Enter_Name".localized
        static let saveButtonTitle : String = "Save".localized
        static let spacing: CGFloat = 10.0
        static let userNameLayoutHeight: CGFloat = 44.0
        static let userPasswordLayoutHeight: CGFloat = 44.0
        static let userLoginLayoutHeight: CGFloat = 44
        static let errorFieldText: String = "Check the fields".localized
    }
    
    enum UserImageLayoutConstant {
        static let height: CGFloat = 120.0
        static let width: CGFloat = 1.0
    }
    
    enum TextFieldConstant {
        static let loginPlaceholder : String = "Enter_Email".localized
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
