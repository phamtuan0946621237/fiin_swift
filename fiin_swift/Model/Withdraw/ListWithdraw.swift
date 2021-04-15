//
//  LoginResponse.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import Foundation

class WithdrawResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [DataWithdrawResponse]?
}
class DataWithdrawResponse {
    var acc_bank : String?
    var bank_name : String?
    var status : String?
    var transaction_amount : Int?
    var transaction_code : String?
    var transaction_date : String?
    var transaction_type : String?
}



