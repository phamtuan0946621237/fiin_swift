//
//  InfoLimitResponse.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import Foundation
//InfoLimitResponse

class InfoLimitResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : DataInfoLimitResponse?
}
class DataInfoLimitResponse {
    var notePayment : String?
    var infoLimitUser : [InfoLimitUserRes]?
    var walletUser : [WalletUserRes]?
    var lending : [InfoLimitLendingRes]?
}
class InfoLimitUserRes {
    var type : String?
    var name : String?
    var limit : String?
    var remaining_limit : Int?
    var used_limit : String?
    var pending_limit : Int?
    var status : Int?
    var notice : String?
}
class WalletUserRes {
    var balance : String?
    var pending_balance : String?
    var currency : String?
}

class InfoLimitLendingRes {
    var investingAmount : Int?
}

