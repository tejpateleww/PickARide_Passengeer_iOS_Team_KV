
import UIKit

protocol OTPTextFieldDelegate   {
    func textFieldDidDelete(currentTextField: OTPTextField)
}

class OtpVC: BaseViewController, UITextFieldDelegate, OTPTextFieldDelegate {
    
    @IBOutlet weak var lblDisplayMesagewithNumber: themeLabel!
    @IBOutlet var txtOtp: [OTPTextField]!
    @IBOutlet weak var lblCountDown: themeLabel!
    @IBOutlet weak var btnAeero: themeButton!
    @IBOutlet weak var btnArrowBottom: NSLayoutConstraint!
    
    @IBOutlet weak var btnResendCode: UIButton!
    
    
    var StringOTP : String = ""
    var clickBtnVerify : (() -> ())?
    var textFieldsIndexes:[OTPTextField:Int] = [:]
    var counter = 30
    var phoneNumber = String()
    var isFrmRegister = false
    var timer = Timer()
    
    var otpUserModel = OTPUserModel()
    var registerReqModel = RegisterRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.reversetimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarInViewController(controller: self, naviColor: colors.appColor.value, naviTitle: NavTitles.verify.value, leftImage: NavItemsLeft.back.value, rightImages: [NavItemsRight.none.value], isTranslucent: true, CommonViewTitles: [], isTwoLabels: false)
    }
    
    override func btnBackAction() {
        super.btnBackAction()
        timer.invalidate()
    }
    
    @IBAction func btnAeeroTap(_ sender: Any) {
        if self.validation(){
            if isFrmRegister {
                self.callRegisterApi()
            }else {
                self.openChangePasswordVC()
            }
        }
    }
    
    @IBAction func btnResendCodeTap(_ sender: Any) {
        self.txtOtp.forEach { (textfield) in
            textfield.text = ""
        }
        
        self.counter = 31
        self.reversetimer()
    }
}

//MARK:- Methods
extension OtpVC{
    func setUpUI(){
        phoneNumber = " " + (registerReqModel.countryCode ?? "") + (registerReqModel.phone ?? "")
        
        let email = registerReqModel.email ?? ""
        let components = email.components(separatedBy: "@")
        let result = Utilities.showingEncreptedEmail(components.first ?? "") + "@" + (components.last ?? "")
        
        lblDisplayMesagewithNumber.text = "VerifyVC_lblCheckSMS".Localized() + " " + result
        txtOtp[0].becomeFirstResponder()
        
        for i in txtOtp {
            i.backgroundColor = .clear
            i.layer.cornerRadius = 4
            i.layer.borderColor = colors.loginViewColor.value.cgColor
            i.layer.borderWidth = 1
            i.tintColor = themeColor
        }
        
        for index in 0 ..< txtOtp.count {
            textFieldsIndexes[txtOtp[index]] = index
        }
        txtOtp[0].myDelegate = self
        txtOtp[1].myDelegate = self
        txtOtp[2].myDelegate = self
        txtOtp[3].myDelegate = self
    }
    
    func reversetimer(){
        timer.invalidate() // just in case this button is tapped multiple times
        //timer? = nil
        lblCountDown.isHidden = false
        btnResendCode.isUserInteractionEnabled = false
        btnResendCode.setTitle("VerifyVC_btnResendCodeIn".Localized(), for: .normal)
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if counter > 0{
            counter -= 1
            lblCountDown.text =  counter > 9 ? "00:\(counter)" : "00:0\(counter)"
        } else {
            lblCountDown.isHidden = true
            btnResendCode.isUserInteractionEnabled = true
            btnResendCode.setTitle("VerifyVC_btnResendCode".Localized(), for: .normal)
        }
    }
    
    func clearAllFields() {
        for index in 0 ..< txtOtp.count {
            txtOtp[index].text = ""
        }
    }
    
    func setNextResponder(_ index:Int?, direction: Direction) {
        guard let index = index else { return }
        
        if direction == .left {
            index == 0 ?
                (_ = txtOtp.first?.resignFirstResponder()) :
                (_ = txtOtp[(index - 1)].becomeFirstResponder())
            if index > 0 {
                let neIndex = index + 1
                for i in neIndex..<txtOtp.count {
                    txtOtp[i].text = ""
                }
            }
        } else {
            index == txtOtp.count - 1 ?
                (_ = txtOtp.last?.resignFirstResponder()) :
                (_ = txtOtp[(index + 1)].becomeFirstResponder())
        }
    }
    
    func setNextResponderBlank(_ index:Int?) {
        if index! >= 0 {
            let neIndex = index! + 1
            for i in neIndex..<txtOtp.count {
                txtOtp[i].text = ""
            }
        }
    }
    
    func openChangePasswordVC(){
        let controller = ChangePasswordVC.instantiate(fromAppStoryboard: .Login)
        controller.submitButtonText = "ChangePassword_btnSetPassword".Localized()
        controller.isChangePassword = false
        
        controller.btnSubmitClosure = {
            userDefaults.setValue(false, forKey: UserDefaultsKey.isUserLogin.rawValue)
            appDel.navigateToLogin()
        }
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.navigationBar.isHidden = true
        self.present(navigationController, animated: true, completion: nil)
    }
}

//MARK:- Validation & Apis
extension OtpVC{
    func validation() -> Bool {
        var strTitle : String?
        var strEnteredOTP = ""
        for index in 0 ..< txtOtp.count {
            strEnteredOTP.append(txtOtp[index].text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        }
        
        if strEnteredOTP == "" {
            strTitle = UrlConstant.RequiredVerificationCode
        }else if self.StringOTP != strEnteredOTP {
            self.clearAllFields()
            strTitle = UrlConstant.InvalidVerificationCode
        }
        
        if let str = strTitle{
            Toast.show(title: UrlConstant.Required, message: str, state: .failure)
            return false
        }
        
        return true
    }
    
    func callRegisterApi(){
        self.otpUserModel.otpVC = self
        self.otpUserModel.webserviceFinalRegister(reqModel: self.registerReqModel)
    }
}

//MARK:- UITextFieldDelegate
extension OtpVC{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .right)
            textField.text = string
            return true
        } else if range.length == 1 {
            setNextResponder(textFieldsIndexes[textField as! OTPTextField], direction: .left)
            textField.text = ""
            return false
        }
        return false
    }
    
    func textFieldDidDelete(currentTextField: OTPTextField) {
        print("delete")
        setNextResponder(textFieldsIndexes[currentTextField], direction: .left)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        setNextResponderBlank(textFieldsIndexes[textField as! OTPTextField])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

class OTPTextField: UITextField {
    var myDelegate: OTPTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete(currentTextField: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9529411765, blue: 0.968627451, alpha: 1)
        self.textAlignment = .center
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0
        self.font = CustomFont.medium.returnFont(17)
        self.tintColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }
}

enum Direction { case left, right }
