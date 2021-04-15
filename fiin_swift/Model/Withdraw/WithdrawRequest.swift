//
//  LoginResponse.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import Foundation

class WithdrawRequestResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : DataWithdrawRequestRespone?
}
class DataWithdrawRequestRespone {
    var transaction_code : String?
    var message_withdrawal : String?
}
