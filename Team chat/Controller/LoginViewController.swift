//
//  LoginViewController.swift
//  Team chat
//
//  Created by Mamadou Bella Diallo on 2018-01-12.
//  Copyright © 2018 Bella Diallo. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Log in" 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if let email = userEmailTextField.text, let password = self.userPasswordTextField.text {
            SVProgressHUD.show()
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (anUser, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    SVProgressHUD.showError(withStatus: "Failed !!! Try again")
                }
                else {
                    // Success
                    
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            })
        }
        
    }
    /**/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToChat" {
//            
//            let destinationViewController = segue.destination as! ChatViewController
//            destinationViewController.currentUser = self.user
//        }
//        
//    }
    

}
