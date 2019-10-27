//
//  ContactViewModel.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation


class ContactViewModel: ContactViewModelProtocol {
    func fetchData<T>(requestURL: String, httpMethod: HttpsMethod, decode: T.Type, param: Dictionary<String, Any>?) where T : Decodable {
        WebServices.requestHttp(urlString: requestURL, method: httpMethod, param: param, decode: { json -> T? in
            guard let response = json as? T else{
                return nil
            }
            
            return response
        }) {[weak self]  (result) in
            
            self?.delegate?.serverResponse(result: result)
            
        }
    }
    
    
     var delegate: ServeResponse?
    
   
}

