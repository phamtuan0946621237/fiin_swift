//
//  AuthenticationService.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import Foundation

class AuthenticationServices {
    class func login(
        phone : String,
        pin : String,
        success : @escaping (_ res : LoginResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["phone" : phone,"pin" : pin]
        let service = Connect()
        service.fetchPost(param : parameters,endUrl : ConstAPI().login)
        service.completionHandler {
            [self] (res) in
            DataModel.login(response: res!,callBack: {
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
