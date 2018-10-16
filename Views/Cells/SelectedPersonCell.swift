//
//  SelectedPersonCell.swift
//  Clic&Farm-iOS
//
//  Created by Guillaume Roux on 15/10/2018.
//  Copyright © 2018 Ekylibre. All rights reserved.
//

import UIKit

class SelectedPersonCell: UITableViewCell {

  // MARK: - Properties

  lazy var personImageView: UIImageView = {
    let typeImageView = UIImageView(frame: CGRect.zero)
    let tintedImage = UIImage(named: "person")?.withRenderingMode(.alwaysTemplate)
    typeImageView.image = tintedImage
    typeImageView.tintColor = UIColor.darkGray
    typeImageView.backgroundColor = UIColor.lightGray
    typeImageView.translatesAutoresizingMaskIntoConstraints = false
    return typeImageView
  }()

  lazy var firstNameLabel: UILabel = {
    let nameLabel = UILabel(frame: CGRect.zero)
    nameLabel.font = UIFont.systemFont(ofSize: 14)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    return nameLabel
  }()

  lazy var lastNameLabel: UILabel = {
    let infosLabel = UILabel(frame: CGRect.zero)
    infosLabel.font = UIFont.boldSystemFont(ofSize: 14)
    infosLabel.translatesAutoresizingMaskIntoConstraints = false
    return infosLabel
  }()

  lazy var deleteButton: UIButton = {
    let deleteButton = UIButton(frame: CGRect.zero)
    let tintedImage = UIImage(named: "trash")?.withRenderingMode(.alwaysTemplate)
    deleteButton.setImage(tintedImage, for: .normal)
    deleteButton.tintColor = UIColor.red
    deleteButton.translatesAutoresizingMaskIntoConstraints = false
    return deleteButton
  }()

  lazy var driverSwitch: UISwitch = {
    let driverSwitch = UISwitch(frame: CGRect.zero)
    driverSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    driverSwitch.onTintColor = AppColor.BarColors.Green
    driverSwitch.tintColor = UIColor.lightGray
    driverSwitch.layer.cornerRadius = 16
    driverSwitch.backgroundColor = UIColor.lightGray
    driverSwitch.translatesAutoresizingMaskIntoConstraints = false
    return driverSwitch
  }()

  lazy var driverLabel: UILabel = {
    let driverLabel = UILabel(frame: CGRect.zero)
    driverLabel.text = "driver".localized
    driverLabel.font = UIFont.systemFont(ofSize: 14)
    driverLabel.textColor = AppColor.TextColors.DarkGray
    driverLabel.translatesAutoresizingMaskIntoConstraints = false
    return driverLabel
  }()
  
  // MARK: - Initialization

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }

  private func setupCell() {
    self.backgroundColor = AppColor.CellColors.LightGray
    self.selectionStyle = .none
    contentView.addSubview(personImageView)
    contentView.addSubview(firstNameLabel)
    contentView.addSubview(lastNameLabel)
    contentView.addSubview(deleteButton)
    contentView.addSubview(driverSwitch)
    contentView.addSubview(driverLabel)
    setupLayout()
  }

  private func setupLayout() {
    NSLayoutConstraint.activate([
      personImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      personImageView.heightAnchor.constraint(equalToConstant: 45),
      personImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
      personImageView.widthAnchor.constraint(equalTo: personImageView.heightAnchor),
      firstNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      firstNameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 10),
      lastNameLabel.centerYAnchor.constraint(equalTo: firstNameLabel.centerYAnchor),
      lastNameLabel.leadingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor, constant: 5),
      lastNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: deleteButton.leadingAnchor, constant: -10),
      deleteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
      deleteButton.heightAnchor.constraint(equalToConstant: 20),
      deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      deleteButton.widthAnchor.constraint(equalToConstant: 20),
      driverSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7.5),
      driverSwitch.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 7.5),
      driverLabel.centerYAnchor.constraint(equalTo: driverSwitch.centerYAnchor),
      driverLabel.leadingAnchor.constraint(equalTo: driverSwitch.trailingAnchor, constant: 5)
      ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}