
import UIKit

class MovieSearchViewController: UIViewController {
  


    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var searchBar1: UISearchBar!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbarchange()
        picture("photo")
    }
}

extension MovieSearchViewController {
        
    func searchbarchange() {
        //서치바 상하줄 없애기
        searchBar1.searchBarStyle = .minimal
        searchBar1.placeholder = "영화를 검색해 주세요"
//        searchBar1.layer.cornerRadius = 0
//        searchBar1.layer.borderColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1).cgColor
//        searchBar1.layer.borderWidth = 4
        }
    //영화 이미지 가져오는부분
    func picture(_ movieTitle: String) {
        NetworkController.shared.fetchSearchMovie(apiKey: MovieApi.apiKey, language: MovieApi.language, movieTitle: movieTitle) { result in
            switch result {
            case .success(let movies):
                print("검색 영화: ")
                for (index, movie) in movies.enumerated() {
                    if let posterPath = movie.posterPath {
                        print("- \(MovieApi.imageUrl)\(posterPath)")
                        if let backdropImage = URL(string: "\(MovieApi.imageUrl)\(posterPath)") {
                            DispatchQueue.main.async {
                                switch index {
                                case 0:
                                    self.imageView1.kf.setImage(with: backdropImage)
                                case 1:
                                    self.imageView2.kf.setImage(with: backdropImage)
                                case 2:
                                    self.imageView3.kf.setImage(with: backdropImage)
                                case 3:
                                    self.imageView4.kf.setImage(with: backdropImage)
                                default:
                                    break
                                }
                            }
                        } else {
                            print("영화 포스터 이미지 URL을 생성하는데 실패했습니다.")
                        }
                    } else {
                        print("영화에 포스터 이미지가 없습니다.")
                    }
                }
            case .failure(let error):
                print("영화 목록을 가져오는데 실패했습니다: \(error)")
            }
        }
    }

}
    

