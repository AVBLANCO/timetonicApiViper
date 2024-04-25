//
//  LandingBookConfiguration.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import UIKit


import Foundation
import UIKit

class LandingBookConfiguration {
    static func setup(ui: ListBookUi, parameters: [String: Any] = [:]) -> UIViewController {
        let controller = LandingBookViewController()
        let router = LandingBookRouter(view: controller)
        let presenter = LandingBookPresenter(ui: ui, interactor: LandingBookInteractor(), router: router as? ILoginPageRouter)
        let manager = LandingBookManager()
        
//        controller.interactor = presenter.interactor
        controller.router = router
//        presenter.interactor.parameters = parameters
        return controller
    }
}

