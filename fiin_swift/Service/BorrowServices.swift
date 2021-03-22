//
//  BorrowServices.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import Foundation

class BorrowServices {
    class func listBorrow(
        page : Int,
        success : @escaping (_ res : ListBorrowResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["page" : page]
        let service = Connect()
        service.fetchGet(parram : parameters,endUrl : ConstAPI().borrowList)
        service.completionHandler {
            [self] (res) in
            DataModel.BorrowList(response: res!,callBack: {
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
