//
//  DetailBookRouter.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import UIKit

protocol IDetailBookRouter: AnyObject {
    // do someting...
    func onClickDetail()
    func showNotNetwork()
}


class DetailBookRouter {
    weak var view: DetailBookViewController?
       
       init(view: DetailBookViewController?) {
           self.view = view
       }
       
       func onClickDetail() {
           let alert = UIAlertController(title: "Alerta!", message: "Informacion ", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               self.view?.dismiss(animated: true) { [weak self] in
                   self?.navigateToHome()
               }
           }))
           alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action: UIAlertAction!) in
               alert.dismiss(animated: true, completion: nil)
           }))
           self.view?.present(alert, animated: true, completion: nil)
       }
       
       func showNotNetwork() {
           
           DispatchQueue.main.async {
               let alert = UIAlertController(title: "Alert", message: "Oops, Internet connection failed", preferredStyle: .alert)
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
       }
       
       func navigateToHome() {
           let viewController = LandingBookViewController()
           viewController.navigationController?.popToRootViewController(animated: true)
       }
}
