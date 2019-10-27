//
//  URLRequest.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

public class HeaderRequest{
    
    class func requestWithHeaders(httpMethod: HttpsMethod, url: String,parameters:Dictionary<String, Any>?) -> URLRequest? {
        
        guard let validURL = URL(string: url) else{
            return nil
        }
        let postData = try? JSONSerialization.data(withJSONObject: parameters ?? [:], options: [])
        
        var request = URLRequest(url: validURL)
        request.httpMethod = httpMethod.localization
        request.timeoutInterval = 60
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        if(parameters != nil){
            request.httpBody = postData
        }
        
        return request
    }
}
