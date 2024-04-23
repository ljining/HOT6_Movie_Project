
import UIKit

class MovieSearch2ViewController: UIViewController {

    @IBOutlet weak var MAGA6BOXLabel2: UILabel!
    @IBOutlet weak var searchBar2: UISearchBar!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbarchange2()

    
    }
}

extension MovieSearch2ViewController {
    
    func searchbarchange2(){
        searchBar2.searchBarStyle = .minimal
        searchBar2.layer.cornerRadius = 25
        searchBar2.placeholder = "영화를 검색해 주세요"
    }
    
}
