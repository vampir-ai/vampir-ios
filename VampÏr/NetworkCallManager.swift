//
//  NetworkCallManager.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkCallManager{
    static func baseURLRequest(urlString: String, parameters: [String: Any], method: HTTPMethod, completion: @escaping (_ result: [String: Any]) -> (), errorHandler: @escaping (_ errorMessage: String?) -> ()) {
        baseURLRequest(urlString: urlString, parameters: parameters, method: method, header: nil, completion: completion, errorHandler: errorHandler)
    }
    
    static func baseURLRequest(urlString: String, parameters: [String: Any], method: HTTPMethod, header: HTTPHeaders?, completion: @escaping (_ result: [String: Any]) -> (), errorHandler: @escaping (_ errorMessage: String?) -> ()) {
        Alamofire
            .request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON(completionHandler: { response in
                
                //TODO pass error message through error handler
                guard response.result.isSuccess else {
                    errorHandler(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    errorHandler(nil)
                    return
                }
                
                completion(value)
            })
    }

}

