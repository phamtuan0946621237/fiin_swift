//
//  ListSupportResponse.swift
//  fiin_swift
//
//  Created by admin on 3/11/21.
//

import Foundation

class ListSupportResponse {
    var code : String?
    var status : String?
    var message : String?
    var data : [ListSupportDataResponse]?
}
class ListSupportDataResponse {
    var date : String?
    var status : String?
    var description : String?
}

