//
//  AuthRouter.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import Alamofire

struct AuthRouter {
    private let environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func logIn(email: String, password: String) -> URLRequestConvertible {
        return LogIn(environment: environment, email: email, password: password)
    }
}

extension AuthRouter {
    private struct LogIn: RequestRouter {
        
        let environment: Environment
        let email: String
        let password: String
        
        init(environment: Environment, email: String, password: String) {
            self.environment = environment
            self.email = email
            self.password = password
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .post
        
        var path = "/auth"
        
        var parameters: Parameters {
            return [
                "email": email,
                "password": password
            ]
        }
    }
}
