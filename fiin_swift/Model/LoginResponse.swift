//
//  LoginResponse.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import Foundation

class LoginResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : DataLoginResponse?
}
class DataLoginResponse {
    var token : String?
}



