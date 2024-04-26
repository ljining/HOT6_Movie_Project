//
//  myPageViewController.swift
//  Mega6Box
//
//  Created by 김태담 on 4/24/24.
//

import Foundation
import UIKit

class MyPageViewController:UIViewController{
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nickname: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var info: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setGround()
    }
    
    func setGround() {
        nickname.text = UserSettings.shared.userID
        email.text = UserSettings.shared.phoneNumber
    }
    
}
extension MyPageViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPageCell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0  // 원하는 셀 높이 값 설정
    }
}

