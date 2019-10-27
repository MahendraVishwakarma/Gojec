// calling api
// checks internet availability

import Foundation
import UIKit
import SystemConfiguration

public class WebServices{
    
    
    // creates request from fetch data from server.
    class func requestHttp<T:Decodable>(urlString:String,method:HttpsMethod, param:Dictionary<String, Any>?, decode:@escaping(Decodable) -> T?, completion: @escaping (Result<T?,APIError>)->()){
    
        let url = urlString
        guard let request = HeaderRequest.requestWithHeaders(httpMethod: method, url: url, parameters: param) else{
            completion(Result.failure(APIError.failedRequest("HTTP request is failed")))
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(Result.failure(APIError.failedRequest(error?.localizedDescription)))
                
            } else {
                guard let serverData = data,
                    error == nil else {
                        completion(Result.failure(APIError.failedRequest(error?.localizedDescription)))
                        return
                }
                
                do{
                    
                    if((response as! HTTPURLResponse).statusCode == 204){
                        completion(Result.failure(APIError.failedRequest("204")))
                        return
                    }
                    let decoder = JSONDecoder();
                    let object = try decoder.decode(T.self, from: serverData)
                    
                    completion(Result.success(object))
                } catch let parsingError {
                    
                    completion(Result.failure(APIError.failedRequest(parsingError.localizedDescription)))
                }
            }
        })
        dataTask.resume()
    }
    
    
}




