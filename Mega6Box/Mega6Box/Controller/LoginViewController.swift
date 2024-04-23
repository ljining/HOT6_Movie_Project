//
//  LoginViewController.swift
//  Mega6Box
//
//  Created by 김태담 on 4/23/24.
//

import Foundation
import UIKit

class LoginViewViewController: UIViewController {
    
    @IBOutlet weak var assingButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    
    func setButton(_ button: UIButton) {
        // 모서리 둥글게 설정
        button.layer.cornerRadius = 10 // 모서리의 둥근 정도를 설정합니다. 필요에 따라 이 값을 조정하세요.
        
        // 배경 색상 설정 (옵션)
        button.backgroundColor = UIColor.white // 배경색을 설정합니다. 필요에 따라 색상을 변경하세요.
        
        // 버튼 글씨 색상을 흰색으로 설정
        button.setTitleColor(UIColor.third, for: .normal)
        button.tintColor = UIColor.third
        
        // 버튼의 글씨 폰트 설정 (옵션)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    func setNavigation(backButtonTitle: String? = nil, backButtonImage: UIImage? = nil) {
        // 백 버튼 제목 설정
        if let title = backButtonTitle {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        }
        
        // 백 버튼 이미지 설정
        if let image = backButtonImage {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        }
        
        // 백 버튼 색깔 설정
        self.navigationController?.navigationBar.tintColor = UIColor.third
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton(assingButton)
        setButton(loginButton)
        setNavigation(backButtonTitle: "뒤로가기")
    }
    
    @IBAction func tapAssignBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Assign", bundle: nil)
        // navigationController를 사용하여 뷰 컨트롤러를 push
        if let viewController = storyboard.instantiateViewController(withIdentifier: "AssignViewController") as? AssignViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    @IBAction func tapLoginBtn(_ sender: Any) {
        
    }
}
