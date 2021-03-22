
import Foundation

class InfoUserServices {
    class func infoUser(
        success : @escaping (_ res : InfoUserResponse) -> Void,
        failure : @escaping (_ message : String) -> Void
    ) {
//        let parameters : [String : Any]? = ["page" : page]
        let service = Connect()
        service.fetchGet(parram : nil,endUrl : ConstAPI().infoUser)
        service.completionHandler {
            [self] (res) in
            DataModel.infoUser(response: res!,callBack: {
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
