//
//  LoginPageConfiguration.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import UIKit

class LoginPageConfigurator {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController { // Se cambia 'parameter' a 'parameters'
        let controller = LoginPageViewController()
        let router = LoginPageRouter(view: controller)
//        let presenter = LoginPagePresenter(view: controller as? ILoginPageViewController)
        let interactor = LoginPageInteractor()
        let presenter = LoginPagePresenter(view: controller, interactor: interactor as? ILoginPageInteractor, router: router)
        let manager = LoginPageManager()
        
        
        controller.interactor = interactor as? ILoginPageInteractor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}


