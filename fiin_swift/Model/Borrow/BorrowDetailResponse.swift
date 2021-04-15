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

class BorrowDetailResponse {
    var status : String?
    var code : String?
    var message : String?
    var data : DataBorrowDetailResponse?
}
class DataBorrowDetailResponse {
    var idBorrow : Int?
    var code : String?
    var debtAmount : Int?
    var borrowAmount : Int?
    var userBorrowName : Int?
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
    var numbersOfDateBorrowing : Int?
    var statusCode : String?
    var statusName : String?
    var repaymentTimeStatusCode : String?
    var repaymentTimeStatusName : String?
    var repaymentId : Int?
    var totalReduceAmountContract : Int?
    var totalReduceFeeAmountContract : Int?
    var totalReduceInterestAmountContract : Int?
    
}
