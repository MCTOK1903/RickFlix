//
//  LaunchViewController.swift
//  LoodosFlix
//
//  Created by Celal Tok on 12.05.2021.
//

import UIKit
import FirebaseRemoteConfig

class LaunchViewController: UIViewController {

    // MARK: View
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .systemBlue
        title.font = UIFont.boldSystemFont(ofSize: 27)
        return title
    }()
    
    // MARK: Properties
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
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

// MARK: - Public funcs

extension LaunchViewController {
    
    func checkEthernetConnection() {
        NetworkMonitor.shared.isConnected ? setUpIU() : showAlert()
    }
    
    func setUpIU() {
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        getValueFromFirebase(withExpirationDuration: 0)
        pushToMainVC(time: 1)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
                UIAlertAction in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func pushToMainVC(time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.navigationController?.pushViewController(MovieListViewController(), animated: false)
        }
    }
    
    func getValueFromFirebase(withExpirationDuration: TimeInterval) {
        
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        remoteConfig.configSettings = setting
        
        self.remoteConfig.fetch(withExpirationDuration: withExpirationDuration) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { [weak self] isSucces, error in
                    guard let self = self, error == nil else {
                        return
                    }
                    
                    if let value = self.remoteConfig.configValue(forKey: Constant.FirebaseConsant.REMOTE_CONFIG_KEY).stringValue {
                        DispatchQueue.main.async {
                            self.titleLabel.text = value
                        }
                    }
                }
            } else {
                // OMG
            }
        }
    }
}
