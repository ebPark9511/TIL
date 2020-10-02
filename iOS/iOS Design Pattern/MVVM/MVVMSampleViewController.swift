//
//  MVVMSampleViewController.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/02.
//

import UIKit

class MVVMSampleViewController: UIViewController {
    // viewModel에서 값 업데이트시. 데이터 바인딩으로 view를 업데이트 해주어야 한다 이를 Dynamic 클래스가 제공.
    // 
    var viewModel: MVVMSampleViewModel?
    
    var label = UILabel()
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindViewModel()
    }
     
}

extension MVVMSampleViewController {
    func setUI() {
        view.backgroundColor = .white
        
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        label.textColor = .red
         
        // iOS 14 <=
        // convenience init(type buttonType: UIButton.ButtonType = .system, primaryAction: UIAction?)
        button = UIButton(primaryAction: UIAction(title: "Click me!", handler: { [weak self] _ in  self?.viewModel?.triggeredButtonPressed() }))
        
        guard let button = button else {  return }
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100).isActive = true
        
        
    }
    
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.labelText.bind { self.label.text = $0 }
    }
    
}


 
