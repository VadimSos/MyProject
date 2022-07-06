//
//  SettingsPickerCellVC.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 22.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class SettingsPickerCellVC: UIViewController {
    
    enum PickerType {
        case datePicker
        case viewPicker
    }

    static let reuseIdentifier: String = "SettingsPickerCellVC"

    var genderPickerData = ["Gender", "Male", "Female"]

    @IBOutlet weak var namePickerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.datePickerMode = .date

        pickerView.dataSource = self
        pickerView.delegate = self
    }

    func setup(type: PickerType) {
        switch type {
        case .datePicker:
            self.namePickerLabel.text = "Date of birth"
            pickerView.isHidden = true
            datePickerView.isHidden = false

        case .viewPicker:
            self.namePickerLabel.text = "Gender"
            pickerView.isHidden = false
            datePickerView.isHidden = true
        }
    }
}

extension SettingsPickerCellVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderPickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderPickerData[row]
    }
}
