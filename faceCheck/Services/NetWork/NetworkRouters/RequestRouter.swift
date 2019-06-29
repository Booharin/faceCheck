//
//  RequestRouter.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import Alamofire

public protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var fullUrl: URL { get }
}

public extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
