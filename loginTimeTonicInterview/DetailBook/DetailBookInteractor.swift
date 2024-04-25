//
//  DetailBookInteractor.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

protocol IDetailBookInteractor: AnyObject {
    var parameters: [String: Any]? { get set }
    
}
class DetailBookInteractor {
    var presenter: IDetailBookPresenter?
    var manager: IDetailBookManager?
    var parameters: [String: Any]?
    
    init(presenter: IDetailBookPresenter?, manager: IDetailBookManager?) {
        self.presenter = presenter
        self.manager = manager
    }
    
}
