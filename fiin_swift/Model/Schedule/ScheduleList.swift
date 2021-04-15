//
//  LoginResponse.swift
//  fiin_swift
//
//  Created by admin on 3/9/21.
//

import Foundation

class BorrowContractResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [DataBorrowContractResponse]?
}
class DataBorrowContractResponse {
    var id : Int?
    var periodName : String?
    var purposeName : String?
    var ContractCode : String?
    var debtAmount : Int?
    var numbersOfDateBorrowing : Int?
    var repaymentDuration : Int?
    var timeStatusCode : String?
    var timeStatusName : String?
    var statusCode : String?
    var statusName : String?
}
class LeddingContractResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [DataLeddingContractResponse]?
}
class DataLeddingContractResponse {
    var id : Int?
    var borrowerName : String?
    var lendingContractCode : String?
    var paymentDate : String?
    var amount : Int?
    var numberOfDateLending : Int?
    var duration : Int?
    var timeStatusCode : String?
    var timeStatusName : String?
    var statusCode : String?
    var statusName : String?
    var periodName : String?
}




