//
//  LoginPageRouter.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import UIKit

protocol ILoginPageRouter: AnyObject {
    func showError(message: String)
    func navigateLandinViewBooks()
    
}

class LoginPageRouter: ILoginPageRouter{
    weak var view: LoginPageViewController?
    
    init(view: LoginPageViewController? ) {
        self.view = view
    }
    
    
    func showError(message: String) {
           let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               switch action.style{
               case .default:
                   print("default")
               case .cancel:
                   print("cancel")
               case .destructive:
                   print("destructive")
               @unknown default:
                   fatalError()
               }
           }))
           self.view?.present(alert, animated: true, completion: nil)
       }
    
    func navigateLandinViewBooks() {
        guard let landingBookVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingBookViewController") as? LandingBookViewController else {
            return
        }
        // Configurar el interactor, presenter y otros componentes necesarios para LandingBookViewController
        let landingBookInteractor = LandingBookInteractor()
        let landingBookPresenter = LandingBookPresenter(ui: landingBookVC, interactor: landingBookInteractor, router: nil)
        landingBookVC.interactor = landingBookInteractor
        landingBookVC.presenter = landingBookPresenter
        
        // Realizar la navegación
        if let navigationController = view?.navigationController {
            navigationController.pushViewController(landingBookVC, animated: true)
        } else {
            view?.present(landingBookVC, animated: true, completion: nil)
        }
    }

    
  
}
