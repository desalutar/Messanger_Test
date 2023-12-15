//
//  ChatsCell.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 14.12.23.
//

import UIKit

class ChatsCell: UITableViewCell {

    static let reuseID = "Cell"

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSettings()
        setViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func viewSettings() {
        backgroundColor = .clear
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        contentView.backgroundColor = UIColor(
            cgColor: CGColor(red: 110/256, green: 132/256, blue: 126/256, alpha: 1))
        contentView.layer.cornerRadius = 20
        contentMode = .center
    }
    
    func setViews() {
        addSubview(userNameLabel)
        addSubview(userMessageLabel)
        
        layoutUserNameLabel()
        layoutUserMessageLabel()
    }
    
    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "User Name"
        return userNameLabel
    }()
    
    private lazy var userMessageLabel: UILabel = {
        let userMessageLabel = UILabel()
        userMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        userMessageLabel.text = "User message text"
        return userMessageLabel
    }()
    
}

extension ChatsCell {
                     // MARK: - Layout Constraints
    private func layoutUserNameLabel() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: topAnchor/*, constant: 5*/),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            userNameLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func layoutUserMessageLabel() {
        NSLayoutConstraint.activate([
            userMessageLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userMessageLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            userMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
//            userMessageLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
