//
//  AuthCoordinator.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//
import UIKit

final class AuthCoordinator: BaseCoordinator {
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showLoginModule()
    }
    
    private func showLoginModule() {
        let controller = AuthViewController(nibName: "AuthViewController",
                                            bundle: nil)
        
        controller.onLogin = { [weak self] in
            self?.toFaceCheck()
            self?.onFinishFlow?()
        }
        
        setAsRoot(controller)
    }
    
    // MARK: - Creating FaceCheck coordinator and show FaceCheck screen
    private func toFaceCheck() {
        let coordinator = FaceCheckCoordinator()
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
