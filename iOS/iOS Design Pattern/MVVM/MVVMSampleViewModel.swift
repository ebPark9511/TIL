//
//  MVVMSampleViewModel.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/02.
//

import Foundation

class MVVMSampleViewModel {
    let labelText = Dynamic("")
    func triggeredButtonPressed() {
        labelText.value = "MVVM TEST"
    }
}
