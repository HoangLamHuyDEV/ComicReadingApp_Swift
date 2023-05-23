//
//  ViewController.swift
//  AppTruyenTranh
//
//  Created by Huy on 09/05/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    
    let tbxUserName = UITextField(frame: CGRect(x:55 , y: 90, width: 300, height: 50))
    
    let tbxPassWord = UITextField(frame: CGRect(x:55 , y: 180, width: 300, height: 50))
    
    let btnLogin = UIButton(frame: CGRect(x: 105, y: 270, width: 200, height: 50))
    
    let btnSignUp = UIButton(frame: CGRect(x: 122, y: 400, width: 170, height: 40))
    
    var dataAcc :[acc] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customScreen()
        createAccData()
    }
    
    func customScreen() {
        //Custom loginView
        let myCustomGreen = UIColor(red: 0.694, green: 1.0, blue: 0.729, alpha: 1.0)
        let myCustomBlue = UIColor(red: 0, green: 209/255, blue: 1, alpha: 1.0)
        
        loginView.layer.cornerRadius = 35
        loginView.clipsToBounds = true
        loginView.layer.borderWidth = 2
        loginView.addSubview(tbxUserName)
        loginView.addSubview(tbxPassWord)
        loginView.addSubview(btnLogin)
        loginView.addSubview(btnSignUp)
        
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
        
        //Custom button login
        btnLogin.backgroundColor = myCustomBlue
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 25
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.titleLabel!.font = UIFont.boldSystemFont(ofSize: 26)
        btnLogin.addTarget(self, action: #selector(btnLoginTapped), for: .touchUpInside)
        
        //custom button Sign up
        btnSignUp.backgroundColor = .systemMint
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.cornerRadius = 20
        btnSignUp.setTitle("Đăng ký", for: .normal)
        btnSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btnSignUp.addTarget(self, action: #selector(btnSignUpTapped), for: .touchUpInside)
    }
    
    @objc func btnSignUpTapped() {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "VCSignUpID") as! SignUpViewController
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func btnLoginTapped() {
        for acc in dataAcc {
            if (acc.userName == tbxUserName.text && acc.password == tbxPassWord.text ) {
                
                goToHHomeScree()
            } else {
                print(dataAcc)
                tbxUserName.text = ""
                tbxPassWord.text = ""
            }
        }
    }
    
    func createAccData() {
        let firstAcc = acc(userName: "Huy", password: "12345", name: "Hoàng Lâm Huy")
        let secondAcc = acc(userName: "userExample", password: "abcdef", name: "Chắc là không giòn đâu")
        dataAcc.append(firstAcc)
        dataAcc.append(secondAcc)
    }
    
    func addAcc (user: String,pass: String,name: String) {
        let addAcc = acc(userName: user, password: pass, name: name)
        dataAcc.append(addAcc)
    }
    
    func goToHHomeScree() {
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "VCHomeID") as! HomeViewController
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

struct acc {
    var userName: String
    var password: String
    var name: String
}

