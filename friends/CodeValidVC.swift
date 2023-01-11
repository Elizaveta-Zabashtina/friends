import UIKit
import FirebaseAuth

class CodeValidVC: UIViewController {

    var verificationID: String!
    @IBOutlet weak var codeTextView: UITextView!
    @IBOutlet weak var checkCodeButton: UIButton!
    
    
    
    @IBAction func checkCodeTapped(_ sender: UIButton) {
        guard let code = codeTextView.text else {return}
        
        let credentional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        Auth.auth().signIn(with: credentional) { (_, error) in
            if error != nil {
                let ac = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                ac.addAction(cancel)
                self.present(ac, animated: true)
            } else {
                self.showContentVC()
            }
        }
    
    }
    
    private func showContentVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "ContentVC") as!
            ContentVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureNavigation()
        setupConfig()
    }

    private func setupConfig(){
        checkCodeButton.isEnabled = false
        
        codeTextView.delegate = self
    }
    
    func configureNavigation() {
        self.navigationItem.title = "Добро пожаловать"
        self.navigationController?.navigationBar.barTintColor = .white
        
    }
    
}

extension CodeValidVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount{
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            checkCodeButton.isEnabled = true
        }
        else {
            checkCodeButton.isEnabled = false
        }
    }
}
