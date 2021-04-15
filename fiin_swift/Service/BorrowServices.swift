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
    
    class func borrowContractConfirm(
        purposeCode : String,
        amount : String,
        duration : String,
        success : @escaping (_ res : BorrowingContractConfirmResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["purposeCode" : purposeCode,"amount" : amount,"duration" : duration]
        let service = Connect()
        service.fetchGet(parram : parameters,endUrl : ConstAPI().borrowingContractConfirm)
        service.completionHandler {
            [self] (res) in
            DataModel.BorrowContractConfirm(response: res!,callBack: {
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
    class func borrowConfirm(
        purposeCode : String,
        amount : String,
        duration : String,
        success : @escaping (_ res : BorrowConfirmResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let parameters : [String : Any]? = ["purposeCode" : purposeCode,"amount" : amount,"duration" : duration]
        let service = Connect()
        service.fetchGet(parram : parameters,endUrl : ConstAPI().borrowConfirm)
        service.completionHandler {
            [self] (res) in
            DataModel.borrowConfirm(response: res!,callBack: {
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
    class func borrowDetail(
        id : Int,
        success : @escaping (_ res : BorrowDetailResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
//        let parameters : [String : Any]? = ["id" : id]
        let service = Connect()
        service.fetchGet(parram : nil,endUrl : ConstAPI().borrowDetail + "/" + String(id))
        service.completionHandler {
            [self] (res) in
            DataModel.borrowDetail(response: res!,callBack: {
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
//
    
    
    class func borrowOption(
        success : @escaping (_ res : BorrowOptionResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
        let service = Connect()
        service.fetchGet(parram : nil,endUrl : ConstAPI().borrowOption)
        service.completionHandler {
            [self] (res) in
            DataModel.BorrowOption(response: res!,callBack: {
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
