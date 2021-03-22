//
//  index.swift
//  fiin_swift
//
//  Created by admin on 3/17/21.
//

import Foundation

class DataModel {
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
    
    class func infoUser(response : [String : Any],callBack : @escaping (_ res : InfoUserResponse) -> Void ) {
        let dataRes = InfoUserResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
        if let dataItem = response["data"] as? [String : Any] {
            let dataLoginResponse = DataInfoUserResponse()
            dataLoginResponse.fullName = dataItem["fullName"] as? String
            dataLoginResponse.code = dataItem["code"] as? String
            dataLoginResponse.phone = dataItem["phone"] as? String
            dataLoginResponse.birthday = dataItem["birthday"] as? String
            dataLoginResponse.email = dataItem["email"] as? String
            dataLoginResponse.avatar = dataItem["avatar"] as? String
            dataLoginResponse.activeMomo = dataItem["activeMomo"] as? Int
            dataLoginResponse.activeEnterprise = dataItem["activeEnterprise"] as? Bool
            dataRes.data = dataLoginResponse
        }
        callBack(dataRes)
    }
    class func InfoLimit(response : [String : Any],callBack : @escaping (_ res : InfoLimitResponse) -> Void ) {
        let dataResInfoLimit = InfoLimitResponse()
        dataResInfoLimit.status = response["status"] as? String
        dataResInfoLimit.code = response["code"] as? String
        dataResInfoLimit.message = response["message"] as? String
        switch dataResInfoLimit.status{
        case "success" :
            if let dataObj = response["data"] as? [String : Any] {
                let dataItem = DataInfoLimitResponse()
                dataItem.notePayment = dataObj["notePayment"] as? String
                var notePaymentData : [InfoLimitUserRes] = []
                var walletUserData : [WalletUserRes] = []
                var ledingInfoLimitData : [InfoLimitLendingRes] = []
                if let notePaymentArr = dataObj["infoLimitUser"] as? [[String : Any]] {
                    for notePaymentObj in notePaymentArr {
                        let notePaymentItem = InfoLimitUserRes()
                        notePaymentItem.name = notePaymentObj["name"] as? String
                        notePaymentItem.type = notePaymentObj["type"] as? String
                        notePaymentItem.limit = notePaymentObj["limit"] as? String
                        notePaymentItem.remaining_limit = notePaymentObj["remaining_limit"] as? Int
                        notePaymentItem.used_limit = notePaymentObj["used_limit"] as? String
                        notePaymentItem.pending_limit = notePaymentObj["pending_limit"] as? Int
                        notePaymentItem.status = notePaymentObj["status"] as? Int
                        notePaymentItem.notice = notePaymentObj["notice"] as? String
                        notePaymentData.append(notePaymentItem)
                    }
                    dataItem.infoLimitUser = notePaymentData
                }
                
                if let walletUserArr = dataObj["walletUser"] as? [[String : Any]] {
                    for walletUserObj in walletUserArr {
                        let walletUserItem = WalletUserRes()
                        walletUserItem.balance = walletUserObj["balance"] as? String
                        walletUserItem.currency = walletUserObj["currency"] as? String
                        walletUserItem.pending_balance = walletUserObj["pending_balance"] as? String
                        
                        walletUserData.append(walletUserItem)
                    }
                    dataItem.walletUser = walletUserData
                }
                
                if let ledingInfoLimitArr = dataObj["lending"] as? [[String : Any]] {
                    for ledingInfoLimitObj in ledingInfoLimitArr {
                        let ledingInfoLimitItem = InfoLimitLendingRes()
                        ledingInfoLimitItem.investingAmount = ledingInfoLimitObj["investingAmount"] as? Int
                        ledingInfoLimitData.append(ledingInfoLimitItem)
                    }
                    dataItem.lending = ledingInfoLimitData
                }
                dataResInfoLimit.data = dataItem
                
                callBack(dataResInfoLimit)
            }
            
            break;
        case "error" :
            break;
        default :
            break;
        }
        
        }
    class func BorrowList(response : [String : Any],callBack : @escaping (_ res : ListBorrowResponse) -> Void ) {
        let dataRes = ListBorrowResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
        switch  dataRes.status{
        case "success":
            if let dataArray = response["data"] as? [[String : Any]] {
                var data : [DataListBorrowResponse] = []
                for dataObj in dataArray {
                    let dataItem = DataListBorrowResponse()
                    dataItem.amount = dataObj["amount"] as? Int
                    dataItem.code = dataObj["code"] as? String
                    dataItem.idList = dataObj["id"] as? Int
                    dataItem.contractTypeCode = dataObj["contractTypeCode"] as? String
                    dataItem.contractTypeName = dataObj["contractTypeName"] as? String
                    dataItem.createdAt = dataObj["createdAt"] as? String
                    dataItem.statusCode = dataObj["statusCode"] as? String
                    dataItem.statusName = dataObj["statusName"] as? String
                    dataItem.purposeName = dataObj["purposeName"] as? String
                    data.append(dataItem)
                }
                dataRes.data = data
            }
            break;
        case "error":
            break;
        default:
            break
        }
        callBack(dataRes)
    }
    
}
//ListBorrowResponse


