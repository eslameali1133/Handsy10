import Foundation
import Alamofire
protocol HttpHelperDelegate {
    func receivedResponse(dictResponse:Any,Tag:Int)
    func receivedErrorWithStatusCode(statusCode:Int)
//    func retryResponse(numberOfrequest:Int)
}
/// HttpHelper class for http request using alamofire libs
class HttpHelper{
    /// **HttpHelparDelegate**  interface on complete request call
    var delegate: HttpHelperDelegate?
    
    var header:HTTPHeaders?
    var numberOfrequest = 0
    var maxNumberOfrequest = 3
    /**
     It get request
     
     ### Usage Example: ###
     ````
     let request = HttpHelper()
     
     request.Get("http://....",parameters:["user":"me"],Tag:1)
     
     ````
     - parameter Url:        The URL.
     - parameter parameters: The parameters. `[:]` by default.
     - parameter Tag:   The parameter tag per request.
     */
    public func requestWithBody (url:String,method:HTTPMethod,parameters:Parameters=[:],tag:Int,header:HTTPHeaders?) {
        Alamofire.request(url , method: method, parameters: parameters, encoding: JSONEncoding.default,headers: header).responseJSON { (response) in
        print(response)
            if response.response == nil {
                self.delegate?.receivedErrorWithStatusCode(statusCode: statusCode.NOT_FOUND)
                return
            }
            if response.response!.statusCode == statusCode.OK  || response.response!.statusCode == statusCode.CREATED
                || response.response!.statusCode == statusCode.NO_CONTENT || response.response!.statusCode == statusCode.ACCEPTED{
                if let JSON = response.result.value {
                    //                        logger(.value, message: JSON)
                   // self.delegate?.receivedResponse(dictResponse: JSON)
                     self.delegate?.receivedResponse(dictResponse: JSON,Tag: tag)
                }
            }else if response.response!.statusCode == statusCode.BAD_GATEWAY || response.response!.statusCode == statusCode.SERVICE_UNAVAILABLE{
                let when = DispatchTime.now() + Double(0.1 * Double(self.numberOfrequest))
                DispatchQueue.main.asyncAfter(deadline: when) {
                    // Your code with delay
//                    self.delegate?.retryResponse(numberOfrequest: self.numberOfrequest)
                    self.numberOfrequest  = self.numberOfrequest +  1
                }
            }else{
                self.delegate?.receivedErrorWithStatusCode(statusCode: response.response!.statusCode)
            }
        }
        
    }
    
    
    
    
    private func request(url:String,method:HTTPMethod,tag:Int,parameters:Parameters=[:],header:HTTPHeaders?){
        //        logger(.value, message: url)
        //        logger(.value, message: parameters
        
        Alamofire.request(url, method: method,parameters: parameters,headers:header)
            .responseJSON { (response) in
                if response.response == nil {
                    self.delegate?.receivedErrorWithStatusCode(statusCode: statusCode.NOT_FOUND)
                    return
                }
                if response.response!.statusCode == statusCode.OK  || response.response!.statusCode == statusCode.CREATED
                    || response.response!.statusCode == statusCode.NO_CONTENT || response.response!.statusCode == statusCode.ACCEPTED{
                    if let JSON = response.result.value {
                        //                        logger(.value, message: JSON)
                        self.delegate?.receivedResponse(dictResponse: JSON,Tag: tag)
                    }
                }else if response.response!.statusCode == statusCode.BAD_GATEWAY || response.response!.statusCode == statusCode.SERVICE_UNAVAILABLE{
                    let when = DispatchTime.now() + Double(0.1 * Double(self.numberOfrequest))
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        // Your code with delay
//                        self.delegate?.retryResponse(numberOfrequest: self.numberOfrequest)
                        self.numberOfrequest  = self.numberOfrequest +  1
                    }
                }else{
                    self.delegate?.receivedErrorWithStatusCode(statusCode: response.response!.statusCode)
                }
        }
    }
}

