//
//  AddWeatherToIntervention.swift
//  Clic&Farm-iOS
//
//  Created by Jonathan DE HAAY on 07/09/2018.
//  Copyright © 2018 Ekylibre. All rights reserved.
//

import UIKit
import CoreData

extension AddInterventionViewController {

  // MARK: - Initialization

  func initializeWeatherView() {
    cloudyButton.layer.borderColor = UIColor.lightGray.cgColor
    cloudyButton.layer.borderWidth = 1
    cloudyButton.layer.cornerRadius = 5

    cloudyPassageButton.layer.borderColor = UIColor.lightGray.cgColor
    cloudyPassageButton.layer.borderWidth = 1
    cloudyPassageButton.layer.cornerRadius = 5

    fogyButton.layer.borderColor = UIColor.lightGray.cgColor
    fogyButton.layer.borderWidth = 1
    fogyButton.layer.cornerRadius = 5

    rainButton.layer.borderColor = UIColor.lightGray.cgColor
    rainButton.layer.borderWidth = 1
    rainButton.layer.cornerRadius = 5

    rainFallButton.layer.borderColor = UIColor.lightGray.cgColor
    rainFallButton.layer.borderWidth = 1
    rainFallButton.layer.cornerRadius = 5

    snowButton.layer.borderColor = UIColor.lightGray.cgColor
    snowButton.layer.borderWidth = 1
    snowButton.layer.cornerRadius = 5

    stormButton.layer.borderColor = UIColor.lightGray.cgColor
    stormButton.layer.borderWidth = 1
    stormButton.layer.cornerRadius = 5

    sunnyButton.layer.borderColor = UIColor.lightGray.cgColor
    sunnyButton.layer.borderWidth = 1
    sunnyButton.layer.cornerRadius = 5
  }

  // MARK: - Actions

  func hideWeatherItems(_ state: Bool) {
    cloudyButton.isHidden = state
    cloudyPassageButton.isHidden = state
    fogyButton.isHidden = state
    rainButton.isHidden = state
    rainFallButton.isHidden = state
    snowButton.isHidden = state
    stormButton.isHidden = state
    sunnyButton.isHidden = state
    windSpeedTextField.isHidden = state
    temperatureTextField.isHidden = state
  }
  
  @IBAction func collapseOrExpandWeatherView(_ sender: Any) {
    if weatherViewHeightConstraint.constant == 70 {
      weatherViewHeightConstraint.constant = 300
      currentWeatherLabel.isHidden = true
      weatherCollapseButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
      hideWeatherItems(false)
    } else {
      weatherViewHeightConstraint.constant = 70
      currentWeatherLabel.isHidden = false
      hideWeatherItems(true)
      weatherCollapseButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi - 3.14159)
    }
  }
}
