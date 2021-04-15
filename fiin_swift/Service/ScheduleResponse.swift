//
//  AuthenticationService.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import Foundation

class ScheduleServices {
    class func listBorrowContract(
        page : Int,
        success : @escaping (_ res : BorrowContractResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["page" : page]
        let service = Connect()
        service.fetchGet(parram : parameters,endUrl : ConstAPI().borrowContract)
        service.completionHandler {
            [self] (res) in
            DataModel.listBorrowContract(response: res!,callBack: {
                [self] dataRes in
                switch dataRes.status  {
                    case "success":
                        success(dataRes)
                        break;
                    case "error":
                        failure(dataRes.message!)
                        break;
                    default:
                        break;
                }
            } )
        }
    }
    class func listLenddingContract(
        page : Int,
        success : @escaping (_ res : LeddingContractResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["page" : page]
        let service = Connect()
        service.fetchGet(parram : parameters,endUrl : ConstAPI().leddingContract)
        service.completionHandler {
            [self] (res) in
            DataModel.listLenddingContract(response: res!,callBack: {
                [self] dataRes in
                switch dataRes.status  {
                    case "success":
                        success(dataRes)
                        break;
                    case "error":
                        failure(dataRes.message!)
                        break;
                    default:
                        break;
                }
            } )
        }
    }

}
