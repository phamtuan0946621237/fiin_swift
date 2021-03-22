//
//  InfoLimitServices.swift
//  fiin_swift
//
//  Created by admin on 3/19/21.
//

import Foundation


class InfoLimitServices {
    class func infoLimit(
        success : @escaping (_ res : InfoLimitResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let service = Connect()
        service.fetchGet(parram : nil,endUrl : ConstAPI().infoLimit)
        service.completionHandler {
            [self] (res) in
            DataModel.InfoLimit(response: res!,callBack: {
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
