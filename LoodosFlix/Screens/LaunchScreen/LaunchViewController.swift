//
//  LaunchViewController.swift
//  LoodosFlix
//
//  Created by Celal Tok on 12.05.2021.
//

import UIKit

class LaunchViewController: UIViewController {

    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Loodos"
        title.tintColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 15)
        return title
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        checkEthernetConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - public funcs

extension LaunchViewController {
    
    func checkEthernetConnection() {
        NetworkMonitor.shared.isConnected ? setUpIU() : showAlert()
    }
    
    func setUpIU() {
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        pushToMainVC()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
                UIAlertAction in
                NSLog("OK Pressed")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func pushToMainVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigationController?.pushViewController(ViewController(), animated: true)
        }
    }
}
