//
//  index.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import Foundation

class DataResponse {
    class func login(response : [String : Any],callBack : @escaping (_ res : LoginResponse) -> Void ) {
        let dataRes = LoginResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
        if let dataItem = response["data"] as? [String : Any] {
            let dataLoginResponse = DataLoginResponse()
            dataLoginResponse.token = dataItem["token"] as? String
            dataRes.data = dataLoginResponse
        }
        callBack(dataRes)
    }
}


