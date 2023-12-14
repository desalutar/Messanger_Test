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
        translatesAutoresizingMaskIntoConstraints = false 
        viewSettings()

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
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
    }
}
