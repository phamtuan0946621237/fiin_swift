//
//  Service.swift
//  PokemonCard
//
//  Created by admin on 12/21/20.
//

import Foundation
import Alamofire

class Connect {
    var url = "https://staging-api.fiin.vn/"
    typealias ResCallback = (_ data : [String : Any]?) -> Void
    var callBack : ResCallback?
    
    func completionHandler(callBack : @escaping ResCallback) {
        self.callBack = callBack
    }
    
    func fetchPost(param : [String : Any]?,endUrl : String) {
        AF.request("\(url)\(endUrl)", method: .post, parameters:param, encoding: JSONEncoding.default, headers: APIManager.headers(), interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    func fetchGet(parram : [String : Any]?,endUrl : String) {
        AF.request("\(url)\(endUrl)",method: .get,parameters: parram , encoding: URLEncoding.default,headers: APIManager.headers(),interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
}

class APIManager {

    class func headers() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "X-FIIN-CLIENT-OS" : "ios",
            "X-FIIN-APP-VERSION" : "2.1.8.2"
        ]

        if let authToken = UserDefaults.standard.string(forKey: "token") {
            headers["Authentication"] = "Bearer" + " " + authToken
        }

        return headers
    }
}
