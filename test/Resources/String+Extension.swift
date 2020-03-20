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
    
    // MARK: - Alerts {
    
    enum Alert {
        static let ok = "alertOK".localized,
        cancel = "alertCancel".localized,
        title = "alertTitle".localized,
        placeholder = "alertPlaceholder".localized   
    }

    // MARK: - Errors.

    enum Error {
        static let request = "errorRequest".localized,
        noRUT = "errorNoRUT".localized,
        noInformation = "errorNoInformation".localized
    }
}
