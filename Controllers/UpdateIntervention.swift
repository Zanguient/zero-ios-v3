//
//  UpdateIntervention.swift
//  Clic&Farm-iOS
//
//  Created by Jonathan DE HAAY on 08/10/2018.
//  Copyright © 2018 Ekylibre. All rights reserved.
//

import UIKit
import CoreData

extension AddInterventionViewController {

  func updateWorkingPeriod() {
    let dateFormatter = DateFormatter()
    let selectedDate: String
    let workingPeriods = currentIntervention.workingPeriods?.allObjects as! [WorkingPeriods]
    let date = workingPeriods.first?.executionDate
    let duration = workingPeriods.first?.hourDuration

    dateFormatter.locale = Locale(identifier: "locale".localized)
    dateFormatter.dateFormat = "d MMM"
    selectedDate = dateFormatter.string(from: date!)
    selectedWorkingPeriodLabel.text = String(format: "%@ • %g h", selectedDate, duration!)
    collapseWorkingPeriodImage.isHidden = true
    workingPeriodGestureRecognizer.isEnabled = false
  }

  func loadInterventionData() {
    if interventionState == Intervention.State.Validated.rawValue {
      warningView.isHidden = false
      warningMessage.text = "you_are_in_consult_mode".localized
      interventionType = currentIntervention?.type
      for interventionEquipment in currentIntervention?.interventionEquipments?.allObjects as! [InterventionEquipments] {
        selectedEquipments.append(interventionEquipment)
      }
      for doer in currentIntervention.doers?.allObjects as! [Doers] {
        doers.append(doer)
      }
      for target in currentIntervention?.targets?.allObjects as! [Targets] {
        target.crops?.isSelected = true
        cropsView.selectedCropsCount += 1
        cropsView.selectedSurfaceArea += (target.crops?.surfaceArea)!
      }
      for interventionSeed in currentIntervention?.interventionSeeds?.allObjects as! [InterventionSeeds] {
        selectedInputs.append(interventionSeed)
      }
      for interventionPhyto in currentIntervention?.interventionPhytosanitaries?.allObjects as! [InterventionPhytosanitaries] {
        selectedInputs.append(interventionPhyto)
      }
      for interventionFertilizer in currentIntervention.interventionFertilizers?.allObjects as! [InterventionFertilizers] {
        selectedInputs.append(interventionFertilizer)
      }
      if interventionType == Intervention.InterventionType.Irrigation.rawValue {
        irrigationValueTextField.text = String(currentIntervention.waterQuantity)
        irrigationUnitButton.setTitle(currentIntervention.waterUnit, for: .normal)
        updateIrrigation(self)
        irrigationExpandCollapseImage.isHidden = true
        irrigationGestureRecognizer.isEnabled = false
        tapIrrigationView(self)
      }
      weather = currentIntervention?.weather
      updateWorkingPeriod()
      refreshSelectedEquipment()
      refreshSelectedPersons()
      refreshSelectedInputs()
      refreshWeather()
      disableUserInteraction()
    }
  }
}