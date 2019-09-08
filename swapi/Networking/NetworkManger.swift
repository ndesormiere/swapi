//
//  NetworkManger.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import Alamofire

enum ServiceType: URLConvertible {
    
    case serviceLoadFilms
    case serviceLoadPeople(url: String)

    func asURL() throws -> URL {
        return URL.init(string: self.URLString)!
    }
    
    var URLString: String {
        switch self {
        case .serviceLoadFilms:
            return "https://swapi.co/api/films"
        case .serviceLoadPeople(let url):
            return url
        }
    }
    var requestMethod: Alamofire.HTTPMethod {
        switch self {
        case .serviceLoadFilms, .serviceLoadPeople:
            return .get
        }
    }
    var headers: [String: String] {
        switch self {
        case .serviceLoadFilms, .serviceLoadPeople:
            var values = ["Content-Type": "application/json"]
            values ["Accept-Encoding"] = "gzip"
            return values
        }
    }
}

class NetworkManger: NSObject {
    class func requestForType(serviceType: ServiceType, params: [String: Any]?, completion: @escaping (_ response: DataResponse<Any>) -> Void) {
        Alamofire.request(serviceType.URLString, method: serviceType.requestMethod, parameters: params, encoding: URLEncoding.default, headers: serviceType.headers).responseJSON { response in
            completion(response)
        }
    }
}
