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

  func initializeWeatherButtons() {
    weatherButtons = [brokenClouds, clearSky, fewClouds, lightRain, mist, showerRain, snow, thunderstorm]

    for index in 0..<weatherButtons.count {
      let image = weatherButtons[index].imageView?.image?.withRenderingMode(.alwaysTemplate)

      weatherButtons[index].imageView?.tintColor = AppColor.TextColors.Blue
      weatherButtons[index].imageView?.image = image
      weatherButtons[index].layer.borderColor = UIColor.lightGray.cgColor
      weatherButtons[index].layer.borderWidth = 1
      weatherButtons[index].layer.cornerRadius = 5
      weatherButtons[index].tag = index
    }
    negativeTemperature.backgroundColor = AppColor.ThemeColors.DarkWhite
    negativeTemperature.layer.borderColor = UIColor.lightGray.cgColor
    negativeTemperature.layer.borderWidth = 1
    negativeTemperature.layer.cornerRadius = 4
  }

  func setupWeatherActions() {
    temperatureTextField.addTarget(self, action: #selector(saveCurrentWeather), for: .editingChanged)
    windSpeedTextField.addTarget(self, action: #selector(saveCurrentWeather), for: .editingChanged)
  }

  // MARK: - Actions

  @IBAction func setTemperatureToNegative(_ sender: UIButton) {
    let temperature = temperatureTextField.text!

    if temperature.count > 0 {
      let index = temperature.index(temperature.startIndex, offsetBy: 1)
      let firstCharacter = temperature[..<index]

      if firstCharacter == "-" {
        negativeTemperature.setTitle("+", for: .normal)
        temperatureTextField.text = String(temperature[index...])
      } else if temperatureTextField.text != "0" {
        negativeTemperature.setTitle("-", for: .normal)
        temperatureTextField.text = "-" + temperature
      }
      saveCurrentWeather(self)
    }
  }

  func hideWeatherItems(_ state: Bool) {
    for index in 0..<weatherButtons.count {
      weatherButtons[index].isHidden = state
    }
    windSpeedTextField.isHidden = state
    temperatureTextField.isHidden = state
    negativeTemperature.isHidden = state
  }

  @IBAction func collapseOrExpandWeatherView(_ sender: Any) {
    let shouldExpand: Bool = (weatherViewHeightConstraint.constant == 70)

    weatherViewHeightConstraint.constant = shouldExpand ? 350 : 70
    currentWeatherLabel.isHidden = shouldExpand
    weatherCollapseButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    hideWeatherItems(!shouldExpand)
  }

  func resetSelectedWeather() {
    for weatherButton in weatherButtons {
      weatherButton.layer.borderWidth = 1
      weatherButton.layer.borderColor = UIColor.lightGray.cgColor
    }
  }

  @IBAction func selectWeather(_ sender: UIButton) {
    let weatherDescriptions = ["BROKEN_CLOUDS", "CLEAR_SKY", "FEW_CLOUDS", "LIGHT_RAIN", "MIST", "SHOWER_RAIN", "SNOW", "THUNDERSTORM"]

    if sender.layer.borderColor == UIColor.lightGray.cgColor {
      resetSelectedWeather()
      weatherIsSelected = true
      weather.weatherDescription = weatherDescriptions[sender.tag]
      sender.layer.borderColor = AppColor.BarColors.Green.cgColor
      sender.layer.borderWidth = 3
    } else {
      resetSelectedWeather()
      weatherIsSelected = false
      weather.weatherDescription = nil
    }
  }

  @objc func saveCurrentWeather(_ sender: Any) {
    if negativeTemperature.titleLabel?.text == "-" && !temperatureTextField.text!.contains("-") {
      temperatureTextField.text = "-" + temperatureTextField.text!
    }
    if temperatureTextField.text == "" && windSpeedTextField.text == "" {
      currentWeatherLabel.text = "not_filled_in".localized
    } else {
      let temperature = (temperatureTextField.text != "" ? temperatureTextField.text : "")
      let wind = (windSpeedTextField.text != "" ? windSpeedTextField.text : "--")
      let currentTemperature = String(format: "temp".localized, temperature!)
      let currentWind = String(format: "wind".localized, wind!)

      currentWeatherLabel.text = currentTemperature + currentWind
    }
    weather.temperature = (temperatureTextField.text! as NSString).doubleValue
    weather.windSpeed = (windSpeedTextField.text! as NSString).doubleValue
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
