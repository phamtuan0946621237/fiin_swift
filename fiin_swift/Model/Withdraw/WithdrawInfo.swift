//
//  LoginResponse.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import Foundation

class WithdrawInfoResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : DataWithdrawInfoResponse?
}
class DataWithdrawInfoResponse {
    var total_amount : String?
    var withdraw_amount : String?
    var withdraw_fee : String?
    var user_receive_name : String?
    var phone : String?
    var cmt : String?
    var acc_bank : String?
    var card_number : String?
    var bank_name : String?
    var bank_branch : String?
    var status : String?
    var transaction_type : String?
    var description : String?
}



