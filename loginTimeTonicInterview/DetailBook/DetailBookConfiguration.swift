//
//  DetailBookConfiguration.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 15/04/24.
//

import Foundation
import UIKit


class DetailBookConfiguration{
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = DetailBookViewController()
        let router = DetailBookRouter(view: controller)
        let presenter = DetailBookPresenter(view: controller)
        let manager = DetailBookManager()
        let interactor = DetailBookInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor as? IDetailBookInteractor
        controller.router = router as?  IDetailBookRouter
        interactor.parameters = parameters
        return controller
    }
}
