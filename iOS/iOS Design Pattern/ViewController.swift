//
//  ViewController.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/02.
//

import UIKit

class ViewController: UITableViewController, Storyboarded {
    var coordinator: MainCoordinator?
    
    let mvvmSampleViewController = MVVMSampleViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
 
// Delegate
extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            coordinator?.mvvmSubscription()
        case 1:
            coordinator?.buySubscription()
        case 2:
            coordinator?.createAccount()
            
        default:
            return
        }
    }
}

// Data source
extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "MVVM"
        case 1:
            cell.textLabel?.text = "Coordinator Pattern - Buy"
        case 2:
            cell.textLabel?.text = "Coordinator Pattern - Create Account"
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
