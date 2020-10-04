//
//  MainCoordinator.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/04.
//

import UIKit
 
class MainCoordinator: Coordinator { 
    var childCoordinators = [Coordinator]()
    var navigation: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }

    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigation.pushViewController(vc, animated: false) 
    }
    
    func mvvmSubscription() {
        let vc = MVVMSampleViewController()
        vc.coordinator = self
        vc.viewModel = MVVMSampleViewModel()
        navigation.pushViewController(vc, animated: true)
    }
    
    func buySubscription() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }

    func createAccount() {
        let vc = CreateAccountViewController.instantiate()
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
}

 
