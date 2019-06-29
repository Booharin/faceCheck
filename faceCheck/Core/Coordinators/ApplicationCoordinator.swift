//
//  ApplicationCoordinator.swift
//  faceCheck
//
//  Created by Booharin on 29/06/2019.
//  Copyright © 2019 Booharin. All rights reserved.
//
import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        toAuth()
    }
    
    // MARK: - Creating Auth coordinator and show authorization screen
    private func toAuth() {
        let coordinator = AuthCoordinator()
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
