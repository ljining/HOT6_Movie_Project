
import UIKit

class DateCell: UICollectionViewCell {

    @IBOutlet weak var datecellView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //셀 선택될때 색상바꾸는것 기본은0이고 클릭될때마다 count가증가함(컬렉션뷰메소드에서)
    var clickCount: Int = 0 {
        didSet {
            if clickCount == 0 {
                datecellView.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
            }
            else {
                datecellView.backgroundColor = UIColor(red: 0.6588, green: 0.6588, blue: 0.6588, alpha: 1)
                
            }
        }
    }
   //중복클릭 허용하지않는부분 색상 연한그레이로 변경
    override var isSelected: Bool {
        didSet {
            if !isSelected {
                datecellView.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
                clickCount = 0

            }
        }
    }
}

