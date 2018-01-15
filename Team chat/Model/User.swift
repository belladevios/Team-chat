//
//  User.swift
//  Team chat
//
//  Created by Mamadou Bella Diallo on 2018-01-13.
//  Copyright © 2018 Bella Diallo. All rights reserved.
//

import Foundation

class User  {
    var name:String = "bella \(Int(arc4random_uniform(7)))"
    var email:String = ""
    var password:String = ""
}
