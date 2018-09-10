//
//  StringExtension.swift
//  Clic&Farm-iOS
//
//  Created by Jonathan DE HAAY on 06/09/2018.
//  Copyright © 2018 Ekylibre. All rights reserved.
//

import UIKit

protocol Localizable {
  var localized: String { get }
}

extension String: Localizable {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}

protocol XIBLocalizable {
  var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      text = key?.localized
    }
  }
}

extension UIButton: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      setTitle(key?.localized, for: .normal)
    }
  }
}
