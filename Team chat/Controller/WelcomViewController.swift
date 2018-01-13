//
//  ViewController.swift
//  Team chat
//
//  Created by Mamadou Bella Diallo on 2018-01-12.
//  Copyright © 2018 Bella Diallo. All rights reserved.
//

import UIKit

class WelcomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToRegister", sender: self)
    }
    
}

