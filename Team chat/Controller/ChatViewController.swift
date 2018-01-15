//
//  ChatViewController.swift
//  Team chat
//
//  Created by Mamadou Bella Diallo on 2018-01-12.
//  Copyright © 2018 Bella Diallo. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var messageArray:[Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageTextField.delegate = self
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource =  self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        self.messageTableView.addGestureRecognizer(tapGesture)
        
        self.messageTableView.register(UINib(nibName:"MessageCell", bundle:nil), forCellReuseIdentifier: "messageCustumCell")
        
        self.messageTableView.separatorStyle = .none
        
        self.configureTableView()
        self.retrieveMessages()
    }

    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        self.sendMessage()
    }

    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCustumCell", for: indexPath) as! MessageCell
        if indexPath.row < self.messageArray.count {
            
            let message = self.messageArray[indexPath.row]
            cell.userNameLabel.text = message.sender?.name
            cell.userMessageLabel.text = message.messageBody
            
            if message.sender?.email == Auth.auth().currentUser?.email {
                // Message we sent
                cell.avatarImageView.backgroundColor = UIColor.flatLime()
                cell.cellBackgroundView.backgroundColor = UIColor.flatSkyBlue()
            }
            else {
                cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
                cell.cellBackgroundView.backgroundColor = UIColor.flatGray()
            }
        }
        cell.avatarImageView.image = UIImage(named:"egg")
        
        return cell
    }
    
        // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    // MARK:- TableViewTapped
    
    @objc func tableViewTapped() {
        self.messageTextField.endEditing(true)
    }
    
    // MARK:- UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308 // 258 (keyboard) + 50 (compose view)
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK:- configureTableView
    func configureTableView() {
        self.messageTableView.rowHeight = UITableViewAutomaticDimension
        self.messageTableView.estimatedRowHeight = 120.0
    }
    
        // MARK:- retrieveMessages
    func retrieveMessages() {
        
        let messagesDB = Database.database().reference().child("Messages")
        messagesDB.observe(.childAdded) { (snapshot) in
            if let snapshotValue = snapshot.value as? Dictionary<String, String>, let sender = snapshotValue["sender"], let messageBody = snapshotValue["messageBody"], let name = snapshotValue["name"] {
                
                let user = User()
                user.name = name
                user.email = sender
                
                let message = Message()
                message.sender = user
                message.messageBody = messageBody
                
                self.messageArray.append(message)
                
                self.configureTableView()
                self.messageTableView.reloadData()
            }
        }
        
    }
    
    func sendMessage() {
        
        let currentUser = Auth.auth().currentUser
        
        if let email = currentUser?.email, let name = currentUser?.displayName, let textMessage = self.messageTextField.text {
            let messagesDB = Database.database().reference().child("Messages")
            
            let messageDictionary:[String: String] = ["sender":email, "messageBody": textMessage , "name":name]
            
            messagesDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Success ! to save message")
                    
                    self.messageTextField.isEnabled = true
                    self.sendButton.isEnabled = true
                    self.messageTextField.text = ""
                }
            }
        }
        
    }
    
    
}
