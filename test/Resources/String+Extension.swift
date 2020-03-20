//
//  String+Extension.swift
//  test
//
//  Created by Jaime Capponi on 19-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

import Foundation


extension String {
    
    var localized: String {
        return NSLocalizedString(
            self,
            tableName: "IonixStrings",
            bundle: .main,
            value: "**\(self)**",
            comment: String()
        )
    }

    // MARK: - UIViewControllers.

    enum HomeViewController {
        static let title = "homeVCTitle".localized,
        name = "homeVCName".localized
    }

    // MARK: - Other messages.

    enum ItemTableViewCell {
        static let empty = "emptyTVCText".localized
    }
    
    // MARK: - Errors.

    enum Errors {
        static let asdf = "".localized
    }
}
