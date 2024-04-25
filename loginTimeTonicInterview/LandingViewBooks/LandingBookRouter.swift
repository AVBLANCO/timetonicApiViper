//
//  LandingBookRouter.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import UIKit

protocol ILandingBookRouter: AnyObject {
    // do someting...
    func showError(message: String)
    func showNotNetwork()
    func openDetailBooks(parameters: BookModel.BookInfo)
}

class LandingBookRouter: ILandingBookRouter {
    func openDetailBooks(parameters: BookModel.BookInfo) {
        
    }
    
    weak var view: LandingBookViewController?
       
       init(view: LandingBookViewController?) {
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
       
       func openDetailProduct(parameters: BookModel.BookInfo) {
           let vc = DetailBookConfiguration.setup(parameters: ["DetailBookViewController" : parameters])
           self.view?.present(vc, animated: true, completion: nil)
       }
       
   }
