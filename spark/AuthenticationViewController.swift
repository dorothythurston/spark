import UIKit
import Alamofire

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContinueButtonState()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        passwordTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressContinueButton() {
        login(emailTextField!.text!, password: passwordTextField!.text!)
    }
    
    func setContinueButtonState() {
        continueButton.enabled = fieldsAreValid()
    }
    
    func textFieldDidChange(textField: UITextField) {
        setContinueButtonState()
    }
    
    private func fieldsAreValid() -> Bool {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        return email.isValidEmailFormat() && password.isValidPasswordFormat()
    }
    
    private func login(email: String, password: String) {
        let headers = Constants.headers
        let parameters = [
            "session": [
                "email": email,
                "password": password
            ]
        ]
        
        Alamofire.request(.POST, Constants.sessionURL, headers: headers,  parameters: parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("Validation Successful")
                case .Failure(let error):
                    print(error)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.debugTextLabel.text = "Incorrect login credentials"
                    }
                }
        }
    }
}
