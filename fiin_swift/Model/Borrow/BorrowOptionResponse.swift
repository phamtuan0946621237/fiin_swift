//
//  BorrowOptionResponse.swift
//  fiin_swift
//
//  Created by admin on 3/23/21.
//

import Foundation

class BorrowOptionResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [DataBorrowOptionResponse]?
}
class DataBorrowOptionResponse {
    var key : String?
    var value : String?
    var amountOption : [Int]?
    var durationOption : [Int]?
    var dataUnitTypeOption : UnitBorrowOptionResponse?
}

class UnitBorrowOptionResponse {
    var unitCode : String?
    var unitName : String?
}
