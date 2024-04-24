
import UIKit

class MoiveReservationViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moivenameLabel: UILabel!
    @IBOutlet weak var moviegenreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var movieinforButton: UIButton!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var lineview: UIView!
    
    let screenigtimeList = Screenigtime.data
    let cellName = "MovieCell"
    let cellReuseIdentifier = "MovieCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        nibcell()
        // 김태담 test
        test()
        
    }
    
    //영화디테일 넘어가는 버튼부분
    @IBAction func moiveinformation(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return }
        self.present(vc, animated: true)
    }
    
    //김태담 test
    func test() {
        // 데이터 생성
        CoreDataManager.shared.createMega6Box(date: Date(), personnel: 10)
        
        // 데이터 읽기
        let boxes = CoreDataManager.shared.fetchMega6Boxes()
        print(boxes)  // 출력하여 확인
        
        // 데이터 업데이트 (첫 번째 박스를 업데이트, 실제 사용 시는 적절한 조건으로 선택 필요)
        if let firstBox = boxes.first {
            CoreDataManager.shared.updateMega6Box(mega6Box: firstBox, newDate: Date(), newPersonnel: 20)
        }
        
        // 데이터 삭제 (첫 번째 박스를 삭제, 실제 사용 시는 적절한 조건으로 선택 필요)
        if let firstBox = boxes.first {
            CoreDataManager.shared.deleteMega6Box(mega6Box: firstBox)
        }
    }
    
    func setUI() {
        lineview.layer.borderWidth = 1
        lineview.layer.borderColor = UIColor.gray.cgColor
    }
}

extension MoiveReservationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //더미데이터 받아오는수대로 count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        screenigtimeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        //상영시간 더미데이터 받아오는부분
        let secreening = screenigtimeList[indexPath.row]
        cell.timeLabel.text = secreening.time
        cell.seatLabel.text = secreening.seat
        cell.layer.cornerRadius = 8
        return cell
    }
    
    //컬렉션뷰 셀사이즈 정하는 부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 3
        print(collectionView.bounds)
        //셀사이즈 정하는부분
        let cellWidth = 338 / 4
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    //nib적용부분
    func nibcell() {
        let nibCell = UINib(nibName: "MovieCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
}
