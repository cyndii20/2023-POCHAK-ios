//
//  SocialLoginViewController.swift
//  pochak
//
//  Created by Seo Cindy on 2023/08/13.
//

import UIKit
import GoogleSignIn
import Alamofire

class SocialJoinViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLayout()
        
        // MARK: - Navigation Controller Back Button Custom
        // Title
        let attrs : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 20)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        // Back Button
        /// 주의점 : backBarButtonItem 사용 시 FirstViewController에서 지정!
        let backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    @IBOutlet weak var goToLoginBtn: UIButton!
    
   // MARK: - Button Design
    private func btnLayout(){
        
        // 소셜 로그인 버튼 디자인
        googleLoginBtn.layer.cornerRadius = 30
        ///테두리 두께 설정해야 함!
        googleLoginBtn.layer.borderWidth = 1
        googleLoginBtn.layer.borderColor = UIColor(named: "gray02")?.cgColor
        appleLoginBtn.layer.cornerRadius = 30
        
        // String Custom : 이미 계정이 있으신가요?
        if let font = UIFont(name: "Pretendard-Bold", size: 16) {
            let customAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.black,
                .underlineStyle: 1
            ]
            let attributedString = NSAttributedString(string: "이미 계정이 있으신가요?", attributes: customAttributes)
            goToLoginBtn.setAttributedTitle(attributedString, for: .normal)
        } else {return}
    }
    
    // MARK: - Button Action
    // to use Push VC has to be in navigation controller : Editor > Embed in > Navigation Controller
    @IBAction func goToLoginBtnTapped(_ sender: UIButton) {
        guard let socialLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "SocialLoginVC") as? SocialLoginViewController else {return}
        self.navigationController?.pushViewController(socialLoginVC, animated: true)
    }
    
    // MARK: - Google Login
    @IBAction func googleLoginAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            // Get User Info
            let user = signInResult.user
            let accessToken = user.accessToken.tokenString
            GoogleLoginDataManager.shared.googleLoginDataManager(accessToken, {resultData in
                guard let isNewMember = resultData.isNewMember else { return }
                self.toProfileSettingsPage(isNewMember)
            })
        }
    }

    // MARK: - Apple Login
    
    
    // MARK: - profileSettingPage로 전환하기
    private func toProfileSettingsPage(_ isNewMember : Bool){
        if isNewMember == true {
            guard let makeProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MakeProfileVC") as? MakeProfileViewController else {return}
            self.navigationController?.pushViewController(makeProfileVC, animated: true)
        }else{
            guard let homeTabVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabVC") as? HomeTabViewController else {return}
            self.navigationController?.pushViewController(homeTabVC, animated: true)
        }
    }
    
}
