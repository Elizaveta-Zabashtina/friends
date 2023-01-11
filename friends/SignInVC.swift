import UIKit
import FlagPhoneNumber
import FirebaseAuth
import AuthenticationServices

class SignIn: UIViewController {
  
    // MARK: - SignInWithPhone
    
    var phoneNumber: String?
    var listController: FPNCountryListViewController!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    @IBOutlet weak var fetchCodeButton: UIButton!
    
    @IBAction func fetchCodeTapped(_ sender: UIButton) {
        guard phoneNumber != nil else {return}
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil){
            (verificationID, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                self.showCodeValidVC(verificationID: verificationID ?? "is empty")
            }
        }
    }
    
    private func showCodeValidVC(verificationID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "CodeValidVC") as!
            CodeValidVC
        dvc.verificationID = verificationID
        self.present(dvc, animated: true, completion: nil)
    }
    
    private func setupConfig(){
        fetchCodeButton.isEnabled=false
        
        phoneNumberTextField.displayMode = .list
        phoneNumberTextField.delegate = self
        
        listController=FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: phoneNumberTextField.countryRepository)
        listController.didSelect = { country in
            self.phoneNumberTextField.setFlag(countryCode: country.code)
        }
        
    }
    

    
    // MARK: - SignInWithApple
    
    private let signInAppleButton = ASAuthorizationAppleIDButton() //кнопка не работает, так как не оплачен аккаунт разаботчика
 
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
        view.addSubview(signInAppleButton)
        signInAppleButton.addTarget(self, action: #selector(didTapSignInApple), for: .touchDown)
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        signInAppleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = signInAppleButton.heightAnchor.constraint (equalToConstant: 50)
        heightConstraint.isActive = true
        
        let trailingAnchor = signInAppleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        trailingAnchor.isActive = true
        
        let leadingAnchor = signInAppleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        leadingAnchor.isActive = true

        let bottomAnchor = signInAppleButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 90)
        bottomAnchor.isActive = true

        let centerXAnchor=signInAppleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerXAnchor.isActive = true

    }
    
    @objc func didTapSignInApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
}

extension SignIn: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed!")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let name=credentials.fullName?.givenName
            break
            
        default:
            break
            
            
        }
    }
}
    
    extension SignIn: ASAuthorizationControllerPresentationContextProviding {
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return view.window!
        }
    }

extension SignIn: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //
    }
    
    func fpnDidValidatePhoneNumber(textField: FlagPhoneNumber.FPNTextField, isValid: Bool) {
        if isValid {
            fetchCodeButton.isEnabled = true
            
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        }
        else {
            fetchCodeButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        phoneNumberTextField.text = ""
        self.present(navigationController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            if Auth.auth().currentUser?.uid != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let dvc = storyboard.instantiateViewController(withIdentifier: "ContentVC")
                    as! ContentVC
                self.present(dvc, animated: true, completion: nil)
            }
        }
    }
    
}
