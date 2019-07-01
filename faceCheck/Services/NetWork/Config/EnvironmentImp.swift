//
//  EnvironmentImp.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//
import Foundation

struct EnvironmentImp {
    private init(){}
}

extension EnvironmentImp {
    
    struct Debug: Environment {
        let baseUrl = URL(string: "http://apple.com")!
    }
}
