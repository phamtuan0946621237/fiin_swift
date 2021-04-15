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
    class func BorrowOption(response : [String : Any],callBack : @escaping (_ res : BorrowOptionResponse ) -> Void ) {
        let dataRes = BorrowOptionResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
        switch  dataRes.status{
        case "success":
            if let dataArray = response["data"] as? [[String : Any]] {
                var data : [DataBorrowOptionResponse] = []
                for dataObj in dataArray {
                    let dataItem = DataBorrowOptionResponse()
                    dataItem.key = dataObj["key"] as? String
                    dataItem.value = dataObj["value"] as? String
                    var durationOptionData : [Int] = []
                    if let durationOptionArr = dataObj["durationOption"] as? [Int] {
                        for durationOptionItem in durationOptionArr {
                            durationOptionData.append(durationOptionItem)
                        }
                        dataItem.durationOption = durationOptionData
                    }
                    
                    var amountOptionData : [Int] = []
                    if let amountOptionArr = dataObj["amountOption"] as? [Int] {
                        for amountOptionItem in amountOptionArr {
                            amountOptionData.append(amountOptionItem)
                        }
                        dataItem.amountOption = amountOptionData
                    }
                    
                    var UnitBorrowOptionData  = UnitBorrowOptionResponse()
                    
                    if let UnitBorrowOptionArr = dataObj["dataUnitTypeOption"] as? [String : Any] {
                        UnitBorrowOptionData.unitCode = UnitBorrowOptionArr["unitCode"] as? String
                        UnitBorrowOptionData.unitName = UnitBorrowOptionArr["unitName"] as? String
                    }
                    dataItem.dataUnitTypeOption = UnitBorrowOptionData
                    data.append(dataItem)
                    dataRes.data = data
                }
                
                
            }
        case "error":
            break;
        default:
            break
            
        }
        callBack(dataRes)
    }
    
    class func borrowConfirm(response : [String : Any],callBack : @escaping (_ res : BorrowConfirmResponse) -> Void ) {
        let dataRes = BorrowConfirmResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
//        print("response_dddddd",response["data"])
        var data : [DataBorrowConfirmResponse] = []
        if let dataArr = response["data"] as? [[String : Any]] {
            for dataObj in dataArr {
                let dataOfResponse = DataBorrowConfirmResponse()
                dataOfResponse.amount = dataObj["amount"] as? Int
                dataOfResponse.idBorrow = dataObj["id"] as? Int
                dataOfResponse.purposeName = dataObj["purposeName"] as? String
                dataOfResponse.createdAt = dataObj["createdAt"] as? String
                dataOfResponse.contractTypeCode = dataObj["contractTypeCode"] as? String
                dataOfResponse.contractTypeName = dataObj["contractTypeName"] as? String
                dataOfResponse.statusCode = dataObj["statusCode"] as? String
                dataOfResponse.statusName = dataObj["statusName"] as? String
                data.append(dataOfResponse)
            }
            dataRes.data = data
        }
        callBack(dataRes)
    }
    
    class func listWithdraw(response : [String : Any],callBack : @escaping (_ res : WithdrawResponse) -> Void ) {
        let dataRes = WithdrawResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
//        print("response_dddddd",response["data"])
        var data : [DataWithdrawResponse] = []
        if let dataArr = response["data"] as? [[String : Any]] {
            for dataObj in dataArr {
                let dataOfResponse = DataWithdrawResponse()
                dataOfResponse.acc_bank = dataObj["acc_bank"] as? String
                dataOfResponse.bank_name = dataObj["bank_name"] as? String
                dataOfResponse.status = dataObj["status"] as? String
                dataOfResponse.transaction_amount = dataObj["transaction_amount"] as? Int
                dataOfResponse.transaction_code = dataObj["transaction_code"] as? String
                dataOfResponse.transaction_date = dataObj["transaction_date"] as? String
                dataOfResponse.transaction_type = dataObj["transaction_type"] as? String
//                dataOfResponse.statusName = dataObj["statusName"] as? String
                data.append(dataOfResponse)
            }
            dataRes.data = data
        }
        callBack(dataRes)
    }
    
    class func withdrawInfo(response : [String : Any],callBack : @escaping (_ res : WithdrawInfoResponse) -> Void ) {
        let dataRes = WithdrawInfoResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
//        var data : [DataWithdrawInfoResponse] = []
        if let dataObj = response["data"] as? [String : Any] {
//            for dataObj in dataArr {
                let dataOfResponse = DataWithdrawInfoResponse()
                dataOfResponse.acc_bank = dataObj["acc_bank"] as? String
                dataOfResponse.bank_name = dataObj["bank_name"] as? String
                dataOfResponse.bank_branch = dataObj["bank_branch"] as? String
                dataOfResponse.card_number = dataObj["card_number"] as? String
                dataOfResponse.cmt = dataObj["cmt"] as? String
                dataOfResponse.description = dataObj["description"] as? String
                dataOfResponse.phone = dataObj["phone"] as? String
                dataOfResponse.status = dataObj["status"] as? String
                dataOfResponse.total_amount = dataObj["total_amount"] as? String
                dataOfResponse.transaction_type = dataObj["transaction_type"] as? String
                dataOfResponse.user_receive_name = dataObj["user_receive_name"] as? String
                dataOfResponse.withdraw_amount = dataObj["withdraw_amount"] as? String
                dataOfResponse.withdraw_fee = dataObj["withdraw_fee"] as? String
//                dataOfResponse.statusName = dataObj["statusName"] as? String
//                data.append(dataOfResponse)
//            }
            dataRes.data = dataOfResponse
        }
        callBack(dataRes)
    }
    
    class func withdrawRequest(response : [String : Any],callBack : @escaping (_ res : WithdrawRequestResponse) -> Void ) {
        let dataRes = WithdrawRequestResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
        if let dataObj = response["data"] as? [String : Any] {
            let dataOfResponse = DataWithdrawRequestRespone()
            dataOfResponse.transaction_code = dataObj["transaction_code"] as? String
            dataOfResponse.message_withdrawal = dataObj["message_withdrawal"] as? String
            dataRes.data = dataOfResponse
        }
        callBack(dataRes)
    }
    
    class func borrowDetail(response : [String : Any],callBack : @escaping (_ res : BorrowDetailResponse) -> Void ) {
        let dataRes = BorrowDetailResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
//        print("response_dddddd",response["data"])
//        var data : [DataBorrowDetailResponse] = []
        print("hihealfnlkssg",response["data"])
        if let dataArr = response["data"] as? [String : Any] {
            
//            for dataObj in dataArr {
                let dataObj = DataBorrowDetailResponse()
                dataObj.idBorrow = dataArr["idBorrow"] as? Int
            dataObj.code = dataArr["code"] as? String
            dataObj.debtAmount = dataArr["debtAmount"] as? Int
            dataObj.borrowAmount = dataArr["borrowAmount"] as? Int
            dataObj.userBorrowName = dataArr["userBorrowName"] as? Int
            dataObj.purposeName = dataArr["purposeName"] as? String
            dataObj.purposeCode = dataArr["purposeCode"] as? String
            dataObj.duration = dataArr["duration"] as? Int
            dataObj.startDate = dataArr["startDate"] as? String
            dataObj.endDate = dataArr["endDate"] as? String
            dataObj.interestRate = dataArr["interestRate"] as? Int
            dataObj.interestAmount = dataArr["interestAmount"] as? Int
            dataObj.feeAmount = dataArr["feeAmount"] as? Int
            dataObj.contractTypeCode = dataArr["contractTypeCode"] as? String
            dataObj.contractTypeName = dataArr["contractTypeName"] as? String
            dataObj.numbersOfDateBorrowing = dataArr["numbersOfDateBorrowing"] as? Int
            dataObj.statusCode = dataArr["statusCode"] as? String
            dataObj.statusName = dataArr["statusName"] as? String
            dataObj.repaymentTimeStatusCode = dataArr["repaymentTimeStatusCode"] as? String
            dataObj.repaymentTimeStatusName = dataArr["repaymentTimeStatusName"] as? String
            dataObj.repaymentId = dataArr["repaymentId"] as? Int
            dataObj.totalReduceAmountContract = dataArr["totalReduceAmountContract"] as? Int
            dataObj.totalReduceFeeAmountContract = dataArr["totalReduceFeeAmountContract"] as? Int
            dataObj.totalReduceInterestAmountContract = dataArr["totalReduceInterestAmountContract"] as? Int
                    dataRes.data = dataObj
            }
        callBack(dataRes)
    }
    
    class func BorrowContractConfirm(response : [String : Any],callBack : @escaping (_ res : BorrowingContractConfirmResponse ) -> Void ) {
        let dataRes = BorrowingContractConfirmResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
        switch  dataRes.status{
        case "success":
            if let dataObj = response["data"] as? [String : Any] {
                let dataItem = DataBorrowingContractConfirmResponse()
                dataItem.debtAmount = dataObj["debtAmount"] as? Int
                dataItem.borrowAmount = dataObj["borrowAmount"] as? Int
                dataItem.userBorrowName = dataObj["userBorrowName"] as? String
                dataItem.purposeCode = dataObj["purposeCode"] as? String
                dataItem.purposeName = dataObj["purposeName"] as? String
                dataItem.duration = dataObj["duration"] as? Int
                dataItem.startDate = dataObj["startDate"] as? String
                dataItem.endDate = dataObj["endDate"] as? String
                dataItem.interestRate = dataObj["interestRate"] as? Int
                dataItem.interestAmount = dataObj["interestAmount"] as? Int
                dataItem.feeAmount = dataObj["feeAmount"] as? Int
                dataItem.contractTypeCode = dataObj["contractTypeCode"] as? String
                dataItem.contractTypeName = dataObj["contractTypeName"] as? String
                dataItem.reduceFeeAmount = dataObj["reduceFeeAmount"] as? Int
                dataItem.reduceInterestAmount = dataObj["reduceInterestAmount"] as? Int
                dataItem.totalReduceAmount = dataObj["totalReduceAmount"] as? Int
                var repaymentData : [RepaymentDataBorrowingContractConfirmResponse] = []
                if let repaymentArr = dataObj["repayment"] as? [[String : Any]] {
                    for repaymentObj in repaymentArr {
                        let repaymentItem = RepaymentDataBorrowingContractConfirmResponse()
                        repaymentItem.periodName = repaymentObj["periodName"] as? String
                        repaymentItem.originAmount = repaymentObj["originAmount"] as? Int
                        repaymentItem.debtAmount = repaymentObj["debtAmount"] as? Int
                        repaymentItem.endDate = repaymentObj["endDate"] as? String
                        repaymentItem.timeStatusCode = repaymentObj["timeStatusCode"] as? String
                        repaymentItem.timeStatusName = repaymentObj["timeStatusName"] as? String
                        repaymentItem.statusCode = repaymentObj["statusCode"] as? String
                        repaymentItem.statusName = repaymentObj["statusName"] as? String
                        repaymentItem.reduceFeeAmount = repaymentObj["reduceFeeAmount"] as? Int
                        repaymentItem.reduceInterestAmount = repaymentObj["reduceInterestAmount"] as? Int
                        repaymentItem.totalReduceAmount = repaymentObj["totalReduceAmount"] as? Int
                        repaymentData.append(repaymentItem)
                    }
                    dataItem.repayment = repaymentData
                }
                dataRes.data = dataItem
            }
        case "error":
            break;
        default:
            break
        }
        callBack(dataRes)
    }
    
    class func listLenddingContract(response : [String : Any],callBack : @escaping (_ res : LeddingContractResponse) -> Void ) {
        let dataRes = LeddingContractResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
//        print("response_dddddd",response["data"])
        var data : [DataLeddingContractResponse] = []
        if let dataArr = response["data"] as? [[String : Any]] {
            for dataObj in dataArr {
                let dataOfResponse = DataLeddingContractResponse()
                dataOfResponse.amount = dataObj["amount"] as? Int
                dataOfResponse.borrowerName = dataObj["borrowerName"] as? String
                dataOfResponse.duration = dataObj["duration"] as? Int
                dataOfResponse.lendingContractCode = dataObj["lendingContractCode"] as? String
                dataOfResponse.lendingContractCode = dataObj["lendingContractCode"] as? String
                dataOfResponse.numberOfDateLending = dataObj["numberOfDateLending"] as? Int
                dataOfResponse.paymentDate = dataObj["paymentDate"] as? String
                dataOfResponse.periodName = dataObj["periodName"] as? String
                dataOfResponse.statusCode = dataObj["statusCode"] as? String
                dataOfResponse.statusName = dataObj["statusName"] as? String
                dataOfResponse.timeStatusName = dataObj["timeStatusName"] as? String
                dataOfResponse.timeStatusCode = dataObj["timeStatusCode"] as? String
//                dataOfResponse.statusName = dataObj["statusName"] as? String
                data.append(dataOfResponse)
            }
            dataRes.data = data
        }
        callBack(dataRes)
    }
    class func listBorrowContract(response : [String : Any],callBack : @escaping (_ res : BorrowContractResponse) -> Void ) {
        let dataRes = BorrowContractResponse()
        dataRes.status = response["status"] as? String
        dataRes.code = response["code"] as? String
        dataRes.message = response["message"] as? String
//        print("response_dddddd",response["data"])
        var data : [DataBorrowContractResponse] = []
        if let dataArr = response["data"] as? [[String : Any]] {
            for dataObj in dataArr {
                let dataOfResponse = DataBorrowContractResponse()
                dataOfResponse.debtAmount = dataObj["debtAmount"] as? Int
                dataOfResponse.ContractCode = dataObj["ContractCode"] as? String
                dataOfResponse.id = dataObj["id"] as? Int
                dataOfResponse.numbersOfDateBorrowing = dataObj["numbersOfDateBorrowing"] as? Int
                dataOfResponse.periodName = dataObj["periodName"] as? String
                dataOfResponse.purposeName = dataObj["purposeName"] as? String
                dataOfResponse.repaymentDuration = dataObj["repaymentDuration"] as? Int
//                dataOfResponse. = dataObj["periodName"] as? String
                dataOfResponse.statusCode = dataObj["statusCode"] as? String
                dataOfResponse.statusName = dataObj["statusName"] as? String
                dataOfResponse.timeStatusName = dataObj["timeStatusName"] as? String
                dataOfResponse.timeStatusCode = dataObj["timeStatusCode"] as? String
//                dataOfResponse.statusName = dataObj["statusName"] as? String
                data.append(dataOfResponse)
            }
            dataRes.data = data
        }
        callBack(dataRes)
    }
//
}


