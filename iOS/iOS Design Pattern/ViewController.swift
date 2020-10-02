//
//  ViewController.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/02.
//

import UIKit

class ViewController: UITableViewController {
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
            mvvmSampleViewController.viewModel = MVVMSampleViewModel()
            self.navigationController?.pushViewController(mvvmSampleViewController, animated: true)
            
             
            
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
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
