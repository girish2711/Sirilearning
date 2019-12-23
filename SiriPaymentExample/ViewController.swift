//
//  ViewController.swift
//  SiriPaymentExample
//
//  Created by Adiga, Girish on 12/1/19.
//  Copyright © 2019 Adiga, Girish. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        button.backgroundColor = .red
        button.setTitle("Test Biometric", for: .normal)
        button.addTarget(self, action: #selector(authenticationWithTouchID), for: .touchUpInside)
        
        self.view.addSubview(button)

    }
    
    @objc internal func authenticationWithTouchID(sender: UIButton!) {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Key-fallback text"
        localAuthenticationContext.localizedCancelTitle = "Key-cancel text"

        var authorizationError: NSError?
        let reason = "Key-text specifying the reason for authentication"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return
            }
            print(error)
        }
    }

}

