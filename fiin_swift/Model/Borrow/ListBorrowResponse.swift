//
//  ListBorrowResponse.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import Foundation

class ListBorrowResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [DataListBorrowResponse]?
}
class DataListBorrowResponse {
    var idList : Int?
    var code : String?
    var purposeName : String?
    var createdAt : String?
    var amount : Int?
    var contractTypeCode : String?
    var contractTypeName : String?
    var statusCode : String?
    var statusName : String?
}
