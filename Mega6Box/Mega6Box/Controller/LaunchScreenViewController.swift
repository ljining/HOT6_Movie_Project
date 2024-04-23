//
//  LaunchScreen.swift
//  Mega6Box
//
//  Created by 김태담 on 4/23/24.
//
import UIKit

class LaunchScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 스토리보드 인스턴스 생성
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        // 이동할 뷰 컨트롤러 인스턴스 생성
        let targetViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewViewController
        
        // 화면 전환
        self.present(targetViewController, animated: true, completion: nil)
    }

}
