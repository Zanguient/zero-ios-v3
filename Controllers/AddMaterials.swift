//
//  AddMaterials.swift
//  Clic&Farm-iOS
//
//  Created by Guillaume Roux on 01/10/2018.
//  Copyright © 2018 Ekylibre. All rights reserved.
//

import UIKit

extension AddInterventionViewController {

  // MARK: - Initialization

  func setupMaterialsView() {
    materialsView = MaterialsView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    materialsView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(materialsView)

    NSLayoutConstraint.activate([
      materialsView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      materialsView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -30),
      materialsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      materialsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30)
      ])

    selectedMaterialsTableView.layer.borderWidth  = 0.5
    selectedMaterialsTableView.layer.borderColor = UIColor.lightGray.cgColor
    selectedMaterialsTableView.backgroundColor = AppColor.ThemeColors.DarkWhite
    selectedMaterialsTableView.layer.cornerRadius = 4
    selectedMaterialsTableView.bounces = false
    //selectedMaterialsTableView.dataSource = self
    //selectedMaterialsTableView.delegate = self

    materialsView.exitButton.addTarget(self, action: #selector(closeSelectionView), for: .touchUpInside)
    materialsView.creationView.unitButton.addTarget(self, action: #selector(showUnits), for: .touchUpInside)
    materialsView.addInterventionViewController = self
  }

  // MARK: - Selection

  func selectMaterial(_ material: Materials) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let selectedMaterial = InterventionMaterials(context: managedContext)

    selectedMaterial.unit = material.unit
    selectedMaterial.materials = material
    selectedMaterials.append(selectedMaterial)
    closeSelectionView()
    updateView()
  }

  private func updateView() {
    let shouldExpand = selectedMaterials.count > 0
    let tableViewHeight = (selectedMaterials.count % 4) * 70

    materialsExpandImage.isHidden = !shouldExpand
    materialsHeightConstraint.constant = shouldExpand ? CGFloat(tableViewHeight + 90) : 70
    materialsTableViewHeightConstraint.constant = CGFloat(tableViewHeight)
  }


  // MARK: - Actions

  @IBAction private func tapMaterialsView() {
    let shouldExpand = (materialsHeightConstraint.constant == 70)
    let tableViewHeight = (selectedMaterials.count % 4) * 70

    if selectedMaterials.count == 0 {
      return
    }

    updateCountLabel()
    materialsHeightConstraint.constant = shouldExpand ? CGFloat(tableViewHeight + 90) : 70
    materialsAddButton.isHidden = !shouldExpand
    materialsCountLabel.isHidden = shouldExpand
    materialsExpandImage.transform = materialsExpandImage.transform.rotated(by: CGFloat.pi)
  }

  private func updateCountLabel() {
    if selectedMaterials.count == 1 {
      materialsCountLabel.text = "material".localized
    } else {
      materialsCountLabel.text = String(format: "materials".localized, selectedMaterials.count)
    }
  }

  @objc private func closeSelectionView() {
    materialsView.isHidden = true
    dimView.isHidden = true
  }

  @objc private func showUnits() {
    self.performSegue(withIdentifier: "showMaterialUnits", sender: self)
  }
}