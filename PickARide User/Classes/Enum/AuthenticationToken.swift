//
//  AuthenticationToken.swift
//  CoreSound
//
//  Created by EWW083 on 05/02/20.
//  Copyright © 2020 EWW083. All rights reserved.
//

import UIKit

enum AuthenticationToken:Int{
    
    case user
    
    static var mapper: [AuthenticationToken: String] = [
        .user: ""
    ]
    var string: String {
        return AuthenticationToken.mapper[self]!
    }
    
}
