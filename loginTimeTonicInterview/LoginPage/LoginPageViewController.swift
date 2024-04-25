//
//  LoginPageViewController.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 12/04/24.
//

import UIKit

protocol ILoginPageViewController: AnyObject {
    var router: ILoginPageRouter? { get set }
   
}

class LoginPageViewController: UIViewController ,ILoginPageViewController{
    var interactor: ILoginPageInteractor?
    var router: ILoginPageRouter?

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set info into textfield in ViewController for don writing in the view
        self.textFieldName.text = "android.developer@timetonic.com"
        self.textFieldPassword.text = "Android.developer1"

       
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = textFieldName.text, let password = textFieldPassword.text, !fieldsAreEmpty() else { return }
        interactor?.login(email: email, password: password)
    }

    
    private func fieldsAreEmpty() -> Bool {
        return textFieldName.text?.isEmpty ?? true || textFieldPassword.text?.isEmpty ?? true
    }

    

}

