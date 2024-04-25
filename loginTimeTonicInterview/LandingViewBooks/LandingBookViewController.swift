//
//  landingBookViewController.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 12/04/24.
//

import UIKit
import Foundation
import Network
import CoreLocation

protocol ILandingBookViewController: AnyObject {
    var router: ILandingBookRouter? { get set }
    func setInfoProducts(_ infoModel: [BookModel.BookDetails])
    func loadingHide()
}

class LandingBookViewController: UIViewController {
    var presenter: LandingBookPresenter?
    var interactor: LandingBookInteractor?
    var router: ILandingBookRouter?
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("Init(coder) no esta bien implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        view.backgroundColor = .blue
        presenter?.onViewAppear()
    }
    
    
}

extension LandingBookViewController: ListBookUi {
    func update(allBooks: [BookModel.BookInfo]) {
        print("Datos recibidos \(allBooks)")
    }
}

