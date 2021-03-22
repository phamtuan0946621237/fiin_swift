//
//  AuthenticationService.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import Foundation

class BankInfoServices {
    class func bankInfo(
        success : @escaping (_ res : [BankInfoDataResponse]) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let service = Connect()
        service.fetchGet(parram : nil,endUrl : ConstAPI().bankInfo)
        service.completionHandler {
            [self] (res) in
            if let response = res as? [String : Any] {
                if let status = response["status"] as? String {
                    switch status {
                    case "success":
                        print("respnose",response)
                        var dataRes : [BankInfoDataResponse] = []
                        if let data = response["data"] as? [[String : Any]] {
                            print("data",data)
                            for dataObj in data {
                                let dataItem = BankInfoDataResponse()
                                dataItem.account_holder = dataObj["account_holder"] as? String
                                dataItem.account_number = dataObj["account_number"] as? String
                                dataItem.branch = dataObj["branch"] as? String
                                dataItem.name = dataObj["name"] as? String
                                dataItem.urlImage = dataObj["urlImage"] as? String
                                dataRes.append(dataItem)
                            }
                            success(dataRes)
                        }
                        break;
                    case "error":
                        break;
                    default:
                        break
                    }
                }
                
            }
        }
    }
}

