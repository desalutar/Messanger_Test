//
//  ChatsCell.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 14.12.23.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseIdentifier = "Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 25/256, green: 25/256, blue: 27/256, alpha: 1.0)
        contentView.addSubview(userTextLabel)
        layoutUserTextLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var userTextLabel: UILabel = {
        let userTextLabel = UILabel()
        userTextLabel.textColor = UIColor(red: 136/255, green: 249/255, blue: 57/255, alpha: 1.0)
        let fontSize = userTextLabel.font.pointSize
        userTextLabel.font = UIFont(name: "Verdana", size: fontSize)
        userTextLabel.numberOfLines = 0
        userTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return userTextLabel
    }()
}

                        // MARK: - Layout
extension TableViewCell {
    private func layoutUserTextLabel() {
        NSLayoutConstraint.activate([
            userTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -5),
            userTextLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
}
