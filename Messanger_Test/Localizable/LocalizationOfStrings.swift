//
//  LocalizationOfStrings.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 02.11.23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(
            self,
            comment: "\(self) could not be found in localizable.strings")
    }
}
