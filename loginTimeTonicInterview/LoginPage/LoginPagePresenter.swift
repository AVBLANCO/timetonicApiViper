//
//  LoginPagePresenter.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

protocol ILoginPagePresenter: AnyObject {
    // do someting...
    func loginSuccess(oauthKey: String)
    func loginFailure(error: Error)
    func loadingHide()
}

class LoginPagePresenter {
    weak var view: ILoginPageViewController?
    var interactor: ILoginPageInteractor?
    var router: ILoginPageRouter?
    
    init(view: ILoginPageViewController?, interactor: ILoginPageInteractor?, router: ILoginPageRouter?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension LoginPagePresenter: ILoginPagePresenter {
    
    func loginSuccess(oauthKey: String) {
        view?.router?.navigateLandinViewBooks()
    }
    
    func loginFailure(error: Error) {
        // Logica para el Error
    }
    
    func loadingHide() {
//        self.view?.loadingHide()
    }
}
