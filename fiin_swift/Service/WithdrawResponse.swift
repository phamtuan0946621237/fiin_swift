//
//  AuthenticationService.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import Foundation

class WithdrawServices {
    class func listWithdraw(
        month : String,
        page : Int,
        success : @escaping (_ res : WithdrawResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["month" : month,"page" : page]
        let service = Connect()
        service.fetchPost(param : parameters,endUrl : ConstAPI().listWithdraw)
        service.completionHandler {
            [self] (res) in
            DataModel.listWithdraw(response: res!,callBack: {
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
    
    class func withdrawInfo(
        type : String,
        success : @escaping (_ res : WithdrawInfoResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["transaction_type" : type]
        let service = Connect()
        service.fetchPost(param : parameters,endUrl : ConstAPI().withdrawInfo)
        service.completionHandler {
            [self] (res) in
            DataModel.withdrawInfo(response: res!,callBack: {
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
    
    class func withdrawRequest(
        amount : String,
        pin : String,
        success : @escaping (_ res : WithdrawRequestResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["withdraw_amount" : amount,"transaction_type" : "rut","withdraw_fee" : "7700","pin" : pin]
        let service = Connect()
        service.fetchPost(param : parameters,endUrl : ConstAPI().withdrawRequest)
        service.completionHandler {
            [self] (res) in
            DataModel.withdrawRequest(response: res!,callBack: {
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
