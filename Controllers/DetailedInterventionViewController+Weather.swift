//
//  DetailedInterventionViewController+Weather.swift
//  Clic&Farm-iOS
//
//  Created by Jonathan DE HAAY on 07/09/2018.
//  Copyright © 2018 Ekylibre. All rights reserved.
//

import UIKit
import CoreData

extension AddInterventionViewController {

  // MARK: - Initialization

  func initializeWeatherButtons() {
    weatherButtons = [brokenClouds, clearSky, fewClouds, lightRain, mist, showerRain, snow, thunderstorm]

    for index in 0..<weatherButtons.count {
      weatherButtons[index].layer.borderColor = UIColor.lightGray.cgColor
      weatherButtons[index].layer.borderWidth = 2
      weatherButtons[index].layer.cornerRadius = 5
    }
  }

  // MARK: - Actions

  func hideWeatherItems(_ state: Bool) {
    for index in 0..<weatherButtons.count {
      weatherButtons[index].isHidden = state
    }
    windSpeedTextField.isHidden = state
    temperatureTextField.isHidden = state
  }

  @IBAction func collapseOrExpandWeatherView(_ sender: Any) {
    let shouldExpand: Bool = (weatherViewHeightConstraint.constant == 70)

    weatherViewHeightConstraint.constant = shouldExpand ? 300 : 70
    currentWeatherLabel.isHidden = shouldExpand
    weatherCollapseButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    hideWeatherItems(!shouldExpand)
  }


  @IBAction func selectWeather(_ sender: UIButton) {
    if weatherIsSelected && sender.layer.borderColor == UIColor.lightGray.cgColor {
      for weather in weatherButtons {
        if weather.layer.borderColor == AppColor.BarColors.Green.cgColor {
          weather.layer.borderColor = UIColor.lightGray.cgColor
        }
      }
      sender.layer.borderColor = AppColor.BarColors.Green.cgColor
      weather.weatherDescription = sender.titleLabel?.text
    } else if weatherIsSelected {
      sender.layer.borderColor = UIColor.lightGray.cgColor
      weatherIsSelected = false
    } else {
      sender.layer.borderColor = AppColor.BarColors.Green.cgColor
      weather.weatherDescription = sender.titleLabel?.text
      weatherIsSelected = true
    }
  }

  func initWeather() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let weather = Weather(context: managedContext)

    self.weather = weather
  }
}