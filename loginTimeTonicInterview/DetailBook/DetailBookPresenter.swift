//
//  DetailBookPresenter.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

protocol IDetailBookPresenter: AnyObject {
    
}

class DetailBookPresenter: IDetailBookPresenter {
    weak var view: DetailBookViewController?
    
    init(view: DetailBookViewController?) {
        self.view = view
    }
    
}
