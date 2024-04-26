
import UIKit
import CoreData

class MoiveReservationViewController: UIViewController {
    
    @IBOutlet weak var topcollectionView: UICollectionView!
    @IBOutlet weak var bottomcollectionView: UICollectionView!
    @IBOutlet weak var moivenameLabel: UILabel!
    @IBOutlet weak var moviegenreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var movieinforButton: UIButton!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var cinemaLabel: UILabel!
    @IBOutlet weak var personnelLabel: UILabel!
    @IBOutlet weak var plusbutton: UIButton!
    @IBOutlet weak var minusbutton: UIButton!
    @IBOutlet weak var cinemabutton: UIButton!
    @IBOutlet weak var reservationbutton: UIButton!
    @IBOutlet weak var posterimage: UIImageView!
    
    
    //상영시간 더미데이터부분 
    let screenigtimeList = Screenigtime.data
    //날짜 더미데이터부분
    let dayList = Day.data
//    let cellName = "MovieCell"
//    let cellReuseIdentifier = "MovieCell"
    let topCellReuseIdentifier = "DateCellReuseIdentifier"
    let bottomCellReuseIdentifier = "MovieCellReuseIdentifier"
    //인원수 값 들어가있는부분
    private var personnelInt: Int = 1
   
    
    //구현목록
      //1.서치에서 예매버튼으로 넘어온 데이터값 받아오는거  imageView5부분이랑,genreLabel부분,moivenameLabel,releaseLabel 네가지값 와야함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomcollectionView.delegate = self
        self.bottomcollectionView.dataSource = self
        self.topcollectionView.delegate = self
        self.topcollectionView.dataSource = self
        nibcell()
        setbuttonUI()

    }
    
   
}
//컬렉션뷰작업
extension MoiveReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //더미데이터 받아오는수대로 count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topcollectionView {
            return dayList.count
        } else if collectionView === bottomcollectionView {
            return screenigtimeList.count
        }
        return 0
    }

    //구조체에서 데이터받아서 셀에반영부분
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topcollectionView {
            //예약데이 더미데이터 받아오는부분
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellReuseIdentifier , for: indexPath) as! DateCell
            //cell.dateLabel.text = weekfunc(input: indexPath.row)//텍스트 라벨에 넣어야함
            return cell
        } else {
            //상영시간 더미데이터 받아오는부분
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCellReuseIdentifier, for: indexPath) as! MovieCell
            let secreening = screenigtimeList[indexPath.row]
            cell2.timeLabel.text = secreening.time
            cell2.seatLabel.text = secreening.seat
            cell2.layer.cornerRadius = 8
            return cell2
        }
    }
    
    //컬렉션뷰 셀사이즈 정하는 부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topcollectionView {
            let cellWidth = 338 / 5
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            layout.minimumLineSpacing = 15
            layout.minimumInteritemSpacing = 3
            //셀사이즈 정하는부분
            let cellWidth = 338 / 4
            return CGSize(width: cellWidth, height: cellWidth)
        }
        
    }
    //nibCell 부분
    func nibcell() {
        let moiveCellNib = UINib(nibName: "MovieCell", bundle: nil)
        bottomcollectionView.register(moiveCellNib, forCellWithReuseIdentifier: bottomCellReuseIdentifier)
        let dateCellNib = UINib(nibName: "DateCell", bundle: nil)
        topcollectionView.register(dateCellNib, forCellWithReuseIdentifier: topCellReuseIdentifier)
    }

    //클릭된 셀 활성화 보여주기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topcollectionView {
//            let selectedDate = dayList[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath) as! DateCell
            if cell.clickCount == 1 {
                cell.clickCount = 0
            } else {
                cell.clickCount += 1
            }
        } else {
        // 클릭된 셀을 가져옴
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        // 가져온 셀의 clickCount를 판단
        if cell.clickCount == 1 {
            // clickCount가 1이면 이미 선택되어 있는 셀이므로 다시 회색으로 바꿔주기 -> 값을 0으로 변경
            cell.clickCount = 0
        }
            else {
                cell.clickCount += 1
            }
        }
    }
}

//버튼들,코어데이터부분
extension MoiveReservationViewController {
    //버튼 수정부분
    func setbuttonUI() {
        refreshTextLabel()
        movieinforButton.layer.masksToBounds = true
        movieinforButton.layer.cornerRadius = 15
        reservationbutton.layer.masksToBounds = true
        reservationbutton.layer.cornerRadius = 15
    }
    
    //영화디테일 페이지 넘어가는 버튼부분
    @IBAction func moiveinformation(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return }
        self.present(vc, animated: true)
    }
    
    //인원 마이너스부분
     @IBAction func minusAction(_ sender: UIButton) {
         personnelInt -= 1
         refreshTextLabel()
     }
    //인원 플러스부분
    @IBAction func plusAction(_ sender: UIButton) {
        personnelInt += 1
        refreshTextLabel()
    }
    //인원플러스 한 값을 반영하는것
    private func refreshTextLabel() {
        self.personnelLabel.text = String(personnelInt)
    }
    //예매하기 버튼 누르면 코어데이터 저장
    @IBAction func reservationbutton(_ sender: UIButton) {
        //reservationCreate()
        alertpopup()
    }
    
    //코어데이터부분 예매날짜,예매인원부분
//    func reservationCreate() {
//        let context = ContainerManager.shared.persistentContainer.viewContext
//        let newMega6box = Mega6Box(context: context)
//        newMega6box.personnel = Int16(personnelInt)
//        newMega6box.date = Date()
//        print(personnelInt)
//    }
//    //코어데이터 저장값 확인하기 테스트버튼
//    @IBAction func testbutton(_ sender: UIButton) {
//        testfetch()
//    }
//    //코어데이터 저장값 확인하기 테스트용
//    func testfetch() {
//        let context = ContainerManager.shared.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<Mega6Box> = Mega6Box.fetchRequest()
//            do {
//                let mega6Boxes = try context.fetch(fetchRequest)
//                for mega6Box in mega6Boxes {
//                    print("Personnel: \(mega6Box.personnel) \(String(describing: mega6Box.date))")
//                }
//            } catch {
//                print("Failed to fetch Mega6Boxes: \(error)")
//            }
//        }
//    //숫자를 넣고 스트링값으로 반환하는것
//    func weekfunc(input :Int) -> String {
//        //오늘 날자의 데이터값 가져오는거 시간에대한 정보를 저장
//        let now = Date() //Data() init메소드 == Date.now
//        let calendar = Calendar.current //현재 캘린더 가져와줘 인스턴스로
////        let week = calendar.component(.weekday, from: now)//지금 현재 주를 반환
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ko_KR") //필요한 데이터 커스텀부분 한국어
//        dateFormatter.dateFormat = "MM dd" // 월일만요구하기
//        
//        let tomorrow = Calendar.current.date(byAdding: .day, value: input, to: now)
//        let formattedDate = dateFormatter.string(from: tomorrow!)
//        let retunrweek = calendar.component(.weekday, from: tomorrow!)
//        let weekFormatter = dateFormatter.weekdaySymbols[retunrweek - 1]//0은일요일미국식 -1 하는이유는 한국식으로 요일표시
////        print(weekFormatter)
////        print(formattedDate)
//        return ("\(formattedDate)\n\(weekFormatter) ")
//    }
    
    //예매완료 알럿창
    func alertpopup(){
        let alert = UIAlertController(title: "예매가 완료되었습니다", message: nil, preferredStyle: .alert)
        let okalert = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okalert)
        present(alert, animated: true)
    }
}


