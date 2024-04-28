//
//  myPageViewController.swift
//  Mega6Box
//
//  Created by 김태담 on 4/24/24.
//

import Foundation
import UIKit
import CoreData

class MyPageViewController:UIViewController{
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nickname: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var info: UILabel!
    
    var savemega6Boxes: [Mega6Box] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setGround()
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        //let newMega6box = Mega6Box(context: context)
        let fetchRequest: NSFetchRequest<Mega6Box> = Mega6Box.fetchRequest()
        do {
            try context.fetch(fetchRequest)
            let mega6Boxes = try context.fetch(fetchRequest)
            savemega6Boxes = mega6Boxes
            for mega6Box in mega6Boxes {
                print("Personnel: \(mega6Box.personnel) \n \(String(describing: mega6Box.date)) \n \(mega6Box.id)")
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func setGround() {
        nickname.text = UserSettings.shared.nickName
        email.text = UserSettings.shared.phoneNumber
    }
    
}
extension MyPageViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savemega6Boxes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPageCell", for: indexPath) as! myPageCell
        
        guard let date = savemega6Boxes[indexPath.row].date else {
            print("error")
            return cell
        }
        let calendar = Calendar.current //현재 캘린더 가져와줘 인스턴스로
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") //필요한 데이터
        dateFormatter.dateFormat = "예약일 yyyy / MM월 / dd 일" // 월일만요구하기
        
        let now = Calendar.current.date(byAdding: .day, value: 0, to: date)
        let formattedDate = dateFormatter.string(from: date)
    

        cell.date.text = formattedDate
        cell.num.text = String(savemega6Boxes[indexPath.row].personnel) + " 명"
        cell.getMovieData(Int(savemega6Boxes[indexPath.row].id))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0  // 원하는 셀 높이 값 설정
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            savemega6Boxes.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "예매 취소") { action, indexPath in
            // 데이터와 테이블 뷰에서 아이템 삭제
            let context = CoreDataManager.shared.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Mega6Box> = Mega6Box.fetchRequest()
            do {
                context.delete(self.savemega6Boxes[indexPath.row])
                self.savemega6Boxes.remove(at: indexPath.row)
                try context.save()
            } catch {
                print("Error while deleting or saving: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        // 삭제 버튼의 배경색 설정
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
    }
}

