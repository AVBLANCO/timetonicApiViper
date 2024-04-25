//
//  LandingBookPresenter.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

protocol ListBookUi: AnyObject {
    func update(allBooks: [BookModel.BookInfo])
}

class LandingBookPresenter {
    var ui: ListBookUi?
    private let interactor : LandingBookInteractor
    private let router: ILoginPageRouter?
    
//    init(interactor: LandingBookInteractor) {
//        self.interactor = interactor
//    }
    init(ui: ListBookUi, interactor: LandingBookInteractor, router: ILoginPageRouter?) { // Cambia view a ui
           self.ui = ui
           self.interactor = interactor
           self.router = router
       }
    
    func onViewAppear() {
          interactor.getListOfBooks { result in
              switch result {
              case .success(let books):
                  DispatchQueue.main.async {
                      self.ui?.update(allBooks: books)
                  }
              case .failure(let error):
                  print("Error fetching books: \(error)")
                  // Wrapping Error  Managment
              }
          }
      }
}
