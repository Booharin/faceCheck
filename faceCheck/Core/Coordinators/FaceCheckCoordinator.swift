//
//  FaceCheckCoordinator.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//

import UIKit

final class FaceCheckCoordinator: BaseCoordinator {
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showFaceChecModule()
    }
    
    private func showFaceChecModule() {
        let controller = FaceCheckViewController()
        setAsRoot(controller)
    }
}
