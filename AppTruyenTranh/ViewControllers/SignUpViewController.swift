//
//  SignUpViewController.swift
//  AppTruyenTranh
//
//  Created by Huy on 09/05/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpView: UIView!
    
    let tbxUserName = UITextField(frame: CGRect(x:55 , y: 80, width: 300, height: 50))
    
    let tbxPassWord = UITextField(frame: CGRect(x:55 , y: 170, width: 300, height: 50))
    
    let tbxRePassWord = UITextField(frame: CGRect(x:55 , y: 260, width: 300, height: 50))
    
    let tbxEmail = UITextField(frame: CGRect(x:55 , y: 350, width: 300, height: 50))
    
    let btnSignUp = UIButton(frame: CGRect(x: 110, y: 440, width: 200, height: 50))
    
    let lblReturnLogin = UILabel(frame: CGRect(x: 150, y: 495, width: 200, height: 40))
    
    let btnLogin = UIButton(frame: CGRect(x: 133, y: 530, width: 160, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSignUpView()
    }
    
    func customSignUpView() {
        
        navigationController?.isNavigationBarHidden = true
        let myCustomGreen = UIColor(red: 0.694, green: 1.0, blue: 0.729, alpha: 1.0)
        let myCustomBlue = UIColor(red: 0, green: 209/255, blue: 1, alpha: 1.0)
        
        signUpView.layer.cornerRadius = 35
        signUpView.clipsToBounds = true
        signUpView.layer.borderWidth = 2
        signUpView.addSubview(tbxUserName)
        signUpView.addSubview(tbxPassWord)
        signUpView.addSubview(btnSignUp)
        signUpView.addSubview(tbxRePassWord)
        signUpView.addSubview(tbxEmail)
        signUpView.addSubview(lblReturnLogin)
        signUpView.addSubview(btnLogin)
        
        //Custom text field nhập tài khoản
        let userIcon = UIImage(named: "userIcon")
        tbxUserName.textAlignment = .natural
        tbxUserName.font = UIFont.systemFont(ofSize: 24)
        tbxUserName.textColor = UIColor.black
        tbxUserName.backgroundColor = myCustomGreen
        tbxUserName.layer.cornerRadius = 25
        tbxUserName.placeholder = "Tên tài khoản"
        tbxUserName.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        tbxUserName.layer.borderWidth = 1
        tbxUserName.leftView = UIImageView(image: userIcon)
        tbxUserName.leftViewMode = .unlessEditing
        
        //Custom text field nhập mật khẩu
        let passwordIcon = UIImage(named: "passwordIcon")
        tbxPassWord.textColor = UIColor.black
        tbxPassWord.textAlignment = .natural
        tbxPassWord.backgroundColor = myCustomGreen
        tbxPassWord.layer.cornerRadius = 25
        tbxPassWord.placeholder = "Mật khẩu"
        tbxPassWord.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        tbxPassWord.layer.borderWidth = 1
        tbxPassWord.font = UIFont.systemFont(ofSize: 24)
        tbxPassWord.leftView = UIImageView(image: passwordIcon)
        tbxPassWord.leftViewMode = .unlessEditing
        
        //Custom text field nhập lại mật khẩu
        tbxRePassWord.textColor = UIColor.black
        tbxRePassWord.textAlignment = .natural
        tbxRePassWord.backgroundColor = myCustomGreen
        tbxRePassWord.layer.cornerRadius = 25
        tbxRePassWord.placeholder = "Nhập lại mật khẩu"
        tbxRePassWord.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        tbxRePassWord.layer.borderWidth = 1
        tbxRePassWord.font = UIFont.systemFont(ofSize: 24)
        tbxRePassWord.leftView = UIImageView(image: passwordIcon)
        tbxRePassWord.leftViewMode = .unlessEditing
        
        //Custom text field nhập email
        let emailIcon = UIImage(named: "email")
        tbxEmail.textColor = UIColor.black
        tbxEmail.textAlignment = .natural
        tbxEmail.backgroundColor = myCustomGreen
        tbxEmail.layer.cornerRadius = 25
        tbxEmail.placeholder = "Email"
        tbxEmail.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        tbxEmail.layer.borderWidth = 1
        tbxEmail.font = UIFont.systemFont(ofSize: 24)
        tbxEmail.leftView = UIImageView(image: emailIcon)
        tbxEmail.leftViewMode = .unlessEditing
        
        //Custom button sign up
        btnSignUp.backgroundColor = myCustomBlue
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.cornerRadius = 25
        btnSignUp.setTitle("Đăng ký", for: .normal)
        btnSignUp.titleLabel!.font = UIFont.boldSystemFont(ofSize: 26)
        btnSignUp.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
        
        lblReturnLogin.text = "Đã có tài khoản?"
        
        //Custom trở lại màn login label
        btnLogin.backgroundColor = .systemMint
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 20
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        btnLogin.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)
    }
    
    @objc func btnLoginTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func btnSignUpTapped() {
        if (tbxUserName.text!.isEmpty == false && tbxPassWord.text!.isEmpty == false && tbxRePassWord.text!.isEmpty == false && tbxEmail.text!.isEmpty == false && tbxPassWord.text == tbxRePassWord.text){
            signUpAcc()
        }else {
            tbxEmail.text = ""
            tbxPassWord.text = ""
            tbxUserName.text = ""
            tbxRePassWord.text = ""
        }
    }
    
    func signUpAcc () {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "VCLoginID") as! ViewController
        loginVC.addAcc(user: tbxUserName.text!, pass: tbxPassWord.text!, name: tbxEmail.text!)
        navigationController?.popViewController(animated: true)
    }
}
