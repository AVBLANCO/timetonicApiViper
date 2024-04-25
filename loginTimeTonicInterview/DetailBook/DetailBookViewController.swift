//
//  DetailBookViewController.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import UIKit
import Network

protocol IProductDetailViewController: AnyObject {
    var router: DetailBookRouter? { get set }
}

class DetailBookViewController: UIViewController {
    var interactor: IDetailBookInteractor?
    var router: IDetailBookRouter?
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblTitleBook: UILabel!
    
    @IBOutlet weak var btnSeeMore: UIButton!
    
    @IBOutlet weak var btnCompleteInformation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
