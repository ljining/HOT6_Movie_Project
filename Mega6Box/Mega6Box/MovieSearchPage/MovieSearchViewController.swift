
import UIKit

class MovieSearchViewController: UIViewController {
  

    @IBOutlet weak var MEGA6BOXLabel1: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var searchBar1: UISearchBar!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbarchange()
      
    }
    
}
//magnifyingglass.circle
extension MovieSearchViewController {
    
    func searchbarchange(){
        
//        if let textfield = searchBar1.value(forKey: "searchField") as? UITextField {
//            
//        }
        //서치바 상하줄 없애기
        searchBar1.searchBarStyle = .minimal
        searchBar1.placeholder = "영화를 검색해 주세요"
        searchBar1.layer.cornerRadius = 1
        searchBar1.layer.borderColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1).cgColor
        searchBar1.layer.borderWidth = 1
        
    }
    
   

}
    
