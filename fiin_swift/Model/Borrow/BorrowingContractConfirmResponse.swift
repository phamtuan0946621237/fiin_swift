//
//  BorrowingContractConfirmResponse.swift
//  fiin_swift
//
//  Created by admin on 3/25/21.
//

import Foundation

class BorrowingContractConfirmResponse {
    var status : String?
    var code : String?
    var message : String?
    var data : DataBorrowingContractConfirmResponse?
}
class DataBorrowingContractConfirmResponse {
    var debtAmount : Int?
    var borrowAmount : Int?
    var userBorrowName : String?
    var purposeCode : String?
    var purposeName : String?
    var duration : Int?
    var startDate : String?
    var endDate : String?
    var interestRate : Int?
    var interestAmount : Int?
    var feeAmount : Int?
    var contractTypeCode : String?
    var contractTypeName : String?
    var reduceFeeAmount : Int?
    var reduceInterestAmount : Int?
    var totalReduceAmount : Int?
    var repayment : [RepaymentDataBorrowingContractConfirmResponse]?
//    var promotionCode : Int?
//    var promotionName : Int?
//    var promotionDescription : Int?
}

class RepaymentDataBorrowingContractConfirmResponse {
    var periodName : String?
    var originAmount : Int?
    var debtAmount : Int?
    var endDate : String?
    var timeStatusCode : String?
    var timeStatusName : String?
    var statusCode : String?
    var statusName : String?
    var reduceFeeAmount : Int?
    var reduceInterestAmount : Int?
    var totalReduceAmount : Int?
}
