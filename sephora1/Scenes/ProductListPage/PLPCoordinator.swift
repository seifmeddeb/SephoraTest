//
//  PLPCoordinator.swift
//  sephora1
//
//  Created by Seif Meddeb on 04/01/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class PLPCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager()
        let viewModel = PLPViewModel(networkManager: networkManager)
        let vc = PLPViewController()
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
}
