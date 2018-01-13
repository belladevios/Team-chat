//
//  ChatViewController.swift
//  Team chat
//
//  Created by Mamadou Bella Diallo on 2018-01-12.
//  Copyright © 2018 Bella Diallo. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var currentUser:User?
    var messageArray:[Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(currentUser?.email ?? "")
        
        self.messageTextField.delegate = self
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource =  self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        self.messageTableView.addGestureRecognizer(tapGesture)
        
        self.messageTableView.register(UINib(nibName:"MessageCell", bundle:nil), forCellReuseIdentifier: "messageCustumCell")
        
        self.messageTableView.separatorStyle = .none
        
        self.configureTableView()
    }

    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }

    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCustumCell", for: indexPath) as! MessageCell
        
        cell.avatarImageView.image = UIImage(named:"egg")
        
        return cell
    }
    
        // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3//self.messageArray.count
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
        
        
    }
    
    func sendMessage() {
        
        
        
    }
}
