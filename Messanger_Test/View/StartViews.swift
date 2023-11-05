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
        backgroundColor = appearance.startScreenBackgroundColor
        addSubview(registrationScreenButton)
        addSubview(authorizationScreenButton)
        layoutAuthorizationScreenButton()
        layoutRegistrationScreenButton()
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
}

private extension StartScreenViews {
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

        let authorizationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0.5)
        
        let textFieldLayerBorderColor: UIColor = .systemGray2
        let colorWhite: UIColor = .white
        let colorRed: UIColor = .red
        let userImageCornerRadius = 50.0
        let saveButtonLeading = 100.0
        let loginPlaceholder : String = "Enter_Login".localized
        let passwordPlaceHolder : String = "Enter_Password".localized
        let singInButtonTitle : String = "Enter".localized
        let userNamePlaceholder : String = "Enter_Name".localized
        let saveButtonTitle : String = "Save".localized
        
        let registrationBackgroundColor = UIColor(red: 110/255, green: 164/255, blue: 189/255, alpha: 0)
    }
}
