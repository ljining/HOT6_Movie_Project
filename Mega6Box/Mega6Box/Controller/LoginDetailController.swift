//
//  LoginDetail.swift
//  Mega6Box
//
//  Created by 김태담 on 4/24/24.
//

import UIKit

class LoginDetailController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField(id)
        setTextField(password)
        setTextFieldDelegate()
        setButton(login)
    }
    
    func setTextField(_ textField : UITextField){
        //textField.placeholder = "Enter text here"
        // 테두리 스타일 설정
        textField.borderStyle = .none  // 기본 테두리 제거
        // 테두리 색상과 두께 설정
        textField.layer.borderColor = UIColor.third.cgColor  // 보라색 테두리
        textField.layer.borderWidth = 2.0  // 테두리 두께 2포인트
        
        // 테두리 둥글게 설정
        textField.layer.cornerRadius = 20.0  // 모서리 반경 10포인트
        // padding 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    func setTextFieldDelegate() {
        id.delegate = self
        password.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        switch textField {
        case id:
            id.textColor = UIColor.black
            id.text = ""
        case password:
            password.text = ""
            password.textColor = UIColor.black
            password.isSecureTextEntry = true
        default:
            print("Error textField")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case id:
            if id.text == "" {
                id.text = "아이디"
                id.textColor = UIColor.lightGray
                
            }
        case password:
            if password.text == "" {
                password.text = "비밀번호"
                password.isSecureTextEntry = false
                password.textColor = UIColor.lightGray
            }
        default:
            print("Error textField")
        }
    }
    func setButton(_ button: UIButton) {
        // 모서리 둥글게 설정
        button.layer.cornerRadius = 10 // 모서리의 둥근 정도를 설정합니다. 필요에 따라 이 값을 조정하세요.
        
        // 배경 색상 설정 (옵션)
        button.backgroundColor = UIColor.third // 배경색을 설정합니다. 필요에 따라 색상을 변경하세요.
        
        // 버튼 글씨 색상을 흰색으로 설정
        button.setTitleColor(UIColor.white, for: .normal)
        button.tintColor = UIColor.white
        
        // 버튼의 글씨 폰트 설정 (옵션)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
        
    @IBAction func tapLogin(_ sender: Any) {
        
        if UserSettings.shared.userID == id.text && UserSettings.shared.password == password.text{
            // 다음 스토리보드 이동
            
            label.isHidden = false
            label.text = "로그인 성공"
        }else{
            label.isHidden = false
        }
        
    }
}
