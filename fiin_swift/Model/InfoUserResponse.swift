//
//  InfoUserResponse.swift
//  fiin_swift
//
//  Created by admin on 3/15/21.
//

import Foundation

class InfoUserResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : DataInfoUserResponse?
}
class DataInfoUserResponse {
    var fullName : String?
    var code : String?
    var phone : String?
    var birthday : String?
    var email : String?
    var avatar : String?
    var activeEnterprise : Bool?
    var activeMomo : Int?
}
