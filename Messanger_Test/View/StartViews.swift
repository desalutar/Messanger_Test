//
//  ViewItems.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

protocol StartScreenDelegate: AnyObject {
    func switchToRegistrationController()
    func switchToAuthorizationController()
}

class StartScreenViews : UIView {
    
    weak var delegate: StartScreenDelegate?
    
    private let item : Model?
    private let appearance = Appearance()
    
    init(item: Model? = nil) {
        self.item = item
        super.init(frame: .zero)
        startScreen()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func startScreen() {
        backgroundColor = ColorsConstants.startScreenBackgroundColor
        addSubview(registrationScreenButton)
        addSubview(authorizationScreenButton)
        layoutAuthorizationScreenButton()
        layoutRegistrationScreenButton()
    }
    


    
    // MARK: - UI Items
    private lazy var registrationScreenButton : UIButton = {
        let registrationButton = UIButton()
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle(LocalizedStringsConstant.authorizationScreenButtonTitle, for: .normal)
        registrationButton.layer.cornerRadius = appearance.cornerRadius
        registrationButton.backgroundColor = ColorsConstants.authorizationBackgroundColor
        registrationButton.addTarget(self, action: #selector(registrationHandler),
                                     for: .touchUpInside)
        return registrationButton
    }()
    
    @objc func registrationHandler() {
        delegate?.switchToRegistrationController()
    }
    
    
    private lazy var authorizationScreenButton : UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle(LocalizedStringsConstant.registrationScreenButtonTitle, for: .normal)
        signInButton.backgroundColor = ColorsConstants.registrationBackgroundColor
        signInButton.layer.cornerRadius = appearance.cornerRadius
        signInButton.addTarget(self, action: #selector(signInHandler), for: .touchUpInside)
        return signInButton
    }()
    
    
    @objc func signInHandler() {
        delegate?.switchToAuthorizationController()
    }
    
    
    // MARK: - NSLayoutConstraint
    
    enum AuthorizationLayoutConstant {
        static let authorizationLeadingAnchor = 60.0
        static let authorizationTrailingAnchor = -60.0
        static let authorizationHeightAnchor = 40.0
        static let authorizationBottomAnchor = -90.0
    }
    
    private func layoutAuthorizationScreenButton() {
        NSLayoutConstraint.activate([
            registrationScreenButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AuthorizationLayoutConstant.authorizationLeadingAnchor),
            
            registrationScreenButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AuthorizationLayoutConstant.authorizationTrailingAnchor),
            
            registrationScreenButton.heightAnchor.constraint(equalToConstant: AuthorizationLayoutConstant.authorizationHeightAnchor),
            
            registrationScreenButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: AuthorizationLayoutConstant.authorizationBottomAnchor)
        ])
    }
    
    enum RegistrationLayoutConstant {
        static let registrationWidthAnchor = 70.0
        static let registrationBottomAnchor = 10.0
    }
    private func layoutRegistrationScreenButton() {
        NSLayoutConstraint.activate([
            authorizationScreenButton.centerXAnchor.constraint(equalTo: registrationScreenButton.centerXAnchor),
            
            authorizationScreenButton.widthAnchor.constraint(equalToConstant: RegistrationLayoutConstant.registrationWidthAnchor),
            
            authorizationScreenButton.topAnchor.constraint(
                equalTo: registrationScreenButton.bottomAnchor,
                constant: RegistrationLayoutConstant.registrationBottomAnchor)
        ])
    }
}

private extension StartScreenViews {
    struct Appearance {
        let cornerRadius = 5.0
        let borderWidth = 0.5

        let userImageCornerRadius = 50.0
        let saveButtonLeading = 100.0
    }
    
    enum LocalizedStringsConstant {
        static let authorizationScreenButtonTitle: String = "Registration".localized
        static let registrationScreenButtonTitle: String = "Sign_In".localized
    }
    enum ColorsConstants {
        static let authorizationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0.5)
        static let registrationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
        static let startScreenBackgroundColor = UIColor(red: 45/255, green: 47/255, blue: 57/255, alpha: 1)
        static let textFieldLayerBorderColor: UIColor = .systemGray2
        static let colorWhite: UIColor = .white
        static let colorRed: UIColor = .red
    }
}
