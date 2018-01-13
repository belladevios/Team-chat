//
//  RegisterViewController.swift
//  Team chat
//
//  Created by Mamadou Bella Diallo on 2018-01-12.
//  Copyright © 2018 Bella Diallo. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Register" 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        if let email = self.userEmailTextField.text, let password = self.userPasswordTextField.text {
            // create user to Firebase Database
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (userCreated, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    // Failed to create user
                    print("Error: ", error!)
                    SVProgressHUD.showError(withStatus: "Failed !!! try again")
                }
                else {
                    // Success
                    self.user = User()
                    self.user?.email = email
                    self.user?.password = password
                    
                    self.userEmailTextField.text = ""
                    self.userPasswordTextField.text = ""
                    
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            })
            
        }
        
    }
    /**/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToChat"  {
            let destinationViewController = segue.destination as! ChatViewController
            destinationViewController.currentUser = self.user
        }
        
    }
    

}
