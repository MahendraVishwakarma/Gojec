//
//  Protocols.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

public protocol ContactViewModelProtocol:class {
    var delegate : ServeResponse?{get set}
    func fetchData<T:Decodable>(requestURL:String,httpMethod:HttpsMethod,decode:T.Type,param:Dictionary<String, Any>?)
}

public protocol ServeResponse:class {
    func serverResponse<T:Decodable>(result:Result<T?,APIError>)
}

