//
//  SearchViewController.swift
//  Mega6Box
//
//  Created by 김태담 on 4/25/24.
//

import Foundation
import UIKit

class SearchViewController:UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var searchLabel: UITextField!
    
    override func viewDidLoad(){
        setTextField(searchLabel)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("dd")
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
    
}
