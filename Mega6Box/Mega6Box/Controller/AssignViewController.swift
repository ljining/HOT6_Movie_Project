//
//  AssignViewController.swift
//  Mega6Box
//
//  Created by 김태담 on 4/23/24.
//

import UIKit

class AssignViewController: UIViewController, UITextFieldDelegate {
    
    var birthDate: Date?
    
    @IBOutlet weak var nickname: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    
    @IBOutlet weak var conformPass: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var birthday: UILabel!
    
    @IBOutlet weak var assign: UIButton!
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var profile: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton(assign)
        setTextFieldDelegate()
        profile.setImageRound()
        
        // UIImageView에 UITapGestureRecognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profile.addGestureRecognizer(tapGesture)
        profile.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(birthdayTapped))
        birthday.addGestureRecognizer(tapGesture2)
        birthday.isUserInteractionEnabled = true
    }
    
    
    @IBAction func tapId(_ sender: Any) {
        
    }
    
    @IBAction func tapNickName(_ sender: Any) {
        
    }
    
    @IBAction func tapPassword(_ sender: Any) {
        
    }
    
    @IBAction func tapConformPassword(_ sender: Any) {
        
    }
    
    @IBAction func tapName(_ sender: Any) {
        
    }
    
    @IBAction func tapPhoneNumber(_ sender: Any) {
        
    }
    
    @IBAction func tapAssign(_ sender: Any) {
        UserSettings.shared.userID = id.text
        UserSettings.shared.password = pass.text
        UserSettings.shared.name = name.text
        UserSettings.shared.nickName = nickname.text
        UserSettings.shared.phoneNumber = phoneNum.text
        UserSettings.shared.birthDate = birthDate
        
        print(UserSettings.shared.userID ?? "없음")
        print(UserSettings.shared.password ?? "없음")
        print(UserSettings.shared.name ?? "없음")
        print(UserSettings.shared.phoneNumber ?? "없음")
        print(UserSettings.shared.birthDate ?? "없음")
        print(UserSettings.shared.nickName ?? "없음")
        
        //예외처리 추가
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        // navigationController를 사용하여 뷰 컨트롤러를 push
        if let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewViewController {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func imageTapped() {
        // 이미지 파일 이름이 "newImage"라고 가정하고, Assets.xcassets에서 이미지를 로드
        switch profile.tintColor {
        case UIColor.black:
            profile.tintColor = UIColor.red
        case UIColor.red:
            profile.tintColor = UIColor.blue
        case UIColor.blue:
            profile.tintColor = UIColor.third
        default:
            profile.tintColor = UIColor.black
        }
    }
    
    @objc func birthdayTapped() {
        presentDatePicker()
    }
    
    
    func setTextFieldDelegate() {
        id.delegate = self
        pass.delegate = self
        conformPass.delegate = self
        name.delegate = self
        phoneNum.delegate = self
        nickname.delegate = self
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case id:
            id.text = ""
        case pass:
            pass.text = ""
            pass.isSecureTextEntry = true
        case conformPass:
            conformPass.text = ""
            conformPass.isSecureTextEntry = true
        case name:
            name.text = ""
        case phoneNum:
            phoneNum.text = ""
        case nickname:
            nickname.text = ""
        default:
            print("Error textField")
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case id:
            if id.text == ""{
                id.text = "아이디"
            }
        case pass:
            if pass.text == ""{
                pass.text = "비밀번호"
                conformPass.isSecureTextEntry = false
            }
        case conformPass:
            if conformPass.text == ""{
                conformPass.text = "비밀번호 확인"
                conformPass.isSecureTextEntry = false
            }
        case name:
            if name.text == ""{
                name.text = "이름"
            }
        case phoneNum:
            if phoneNum.text == ""{
                phoneNum.text = "전화번호"
            }
        case nickname:
            if nickname.text == ""{
                nickname.text = "닉네임"
            }
        default:
            print("Error textField")
        }
        
        
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd" // Setting the date format
        return dateFormatter.string(from: date)
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
    
    func presentDatePicker() {
        // Create the alert controller
        let alertController = UIAlertController(title: "\n\n", message: "생일을 선택해주세요", preferredStyle: .actionSheet)
        
        // Configure the date picker
        let datePicker = UIDatePicker(frame: CGRect(x: 5, y: 20, width: 250, height: 200))
        datePicker.datePickerMode = .date
        datePicker.date = Date() // Set to current date or any specific date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date()) // Set maximum date to one year from now
        
        // Add the date picker to the alert controller
        alertController.view.addSubview(datePicker)
        
        // Add an action to handle the selected date
        let selectAction = UIAlertAction(title: "Select", style: .default, handler: { _ in
            let selectedDate = datePicker.date
            // Action with selected date
            //print("Selected Date: \(selectedDate)")
            self.birthDate = datePicker.date
            let formattedDate = self.formatDate(selectedDate)
            self.birthday.text = "\(formattedDate)"
        })
        alertController.addAction(selectAction)
        
        // Add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        self.present(alertController, animated: true)
    }
}
extension UIImageView {
    // 이미지 뷰를 원형으로 만드는 함수
    func setImageRound() {
        // 이미지 뷰의 높이를 기준으로 코너 반경 설정
        self.layer.cornerRadius = self.frame.height / 2
        // 레이어의 마스크를 바운드로 클리핑
        self.layer.masksToBounds = true
    }
}
