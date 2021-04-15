//
//  BorrowConfirmResponse.swift
//  fiin_swift
//
//  Created by admin on 3/29/21.
//

import Foundation
//
//  BorrowingContractConfirmResponse.swift
//  fiin_swift
//
//  Created by admin on 3/25/21.
//

import Foundation

class BorrowConfirmResponse {
    var status : String?
    var code : String?
    var message : String?
    var data : [DataBorrowConfirmResponse]?
}
class DataBorrowConfirmResponse {
    var idBorrow : Int?
    var code : String?
    var purposeName : String?
    var createdAt : String?
    var amount : Int?
    var contractTypeCode : String?
    var contractTypeName : String?
    var statusCode : String?
    var statusName : String?
}
