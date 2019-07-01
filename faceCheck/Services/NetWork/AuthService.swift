//
//  AuthService.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import Alamofire

struct AuthService {
    
    private let router: AuthRouter
    
    init(environment: Environment) {
        router = AuthRouter(environment: environment)
    }
    
    // MARK: - Sending login and password for getting token
    func login(email: String, password: String, completion: @escaping (String?) -> ()) {
        
        Alamofire.request(router.logIn(email: email, password: password))
            .responseJSON(queue: .global()) { response in
                
                // temporary code for test project
                
                #if DEBUG
                print(response)
                #endif
                
                completion("token")
        }
    }
}

