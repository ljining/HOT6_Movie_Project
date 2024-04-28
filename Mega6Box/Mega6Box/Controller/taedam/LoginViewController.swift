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
        if(UserSettings.shared.auto == true){
            let storyboard = UIStoryboard(name: "MainMovieList", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "MainMovieList") as? MainMovieListViewController {
                // Setting the modal presentation style to fullscreen
                viewController.modalPresentationStyle = .fullScreen
                // Presenting the view controller modally
                present(viewController, animated: true)
            }
        }
        let storyboard = UIStoryboard(name: "LoginDetail", bundle: nil)
        // navigationController를 사용하여 뷰 컨트롤러를 push
        if let viewController = storyboard.instantiateViewController(withIdentifier: "LoginDetailController") as? LoginDetailController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
