//
//  BankInfoResponse.swift
//  fiin_swift
//
//  Created by admin on 3/15/21.
//

import Foundation

class BankInfoResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [BankInfoDataResponse]?
}
class BankInfoDataResponse {
    var name : String?
    var account_number : String?
    var branch : String?
    var account_holder : String?
    var urlImage : String?
    var position : Int?
}
