
import UIKit

class MovieSearchViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var searchBar1: UISearchBar!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var movieArr: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar1.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        layoutset()
        
    }
}

//MARK: - 컬렉션뷰설정
extension MovieSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - 컬렉션뷰에서 영화를 선택하면 상세 페이지로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieReservationPage", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MoiveReservationViewController") as? MoiveReservationViewController else {
            return }
        
        if let movieData = movieArr,
           let id = movieData[indexPath.row].id {
            vc.tempMovieId = id
        }
        
        self.present(vc, animated: true)
    }
    
    //레이아웃부분값정하는거
    func layoutset() {
        searchbarchange1()
        let layout = UICollectionViewFlowLayout()
        movieCollectionView.collectionViewLayout = layout
        layout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0.5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieSearchPageCell else { return UICollectionViewCell()
        }
        guard let movies = movieArr else {
            return UICollectionViewCell()
        }
        if let posterPath = movies[indexPath.row].posterPath {
            if let url = URL(string: "\(MovieApi.imageUrl)\(posterPath)") {
                cell.imageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    //쉐도우랑 코너레디어스는 함께 사용이 안됨
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4
    }
    
    //셀사이즈 지정하는부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 170
        let cellheight: CGFloat = 250
        return CGSize(width: cellWidth, height: cellheight)
    }
}
//MARK: - 네트워크 검색데이터 가져오는부분
extension MovieSearchViewController {
    
    func searchMovie(movieTitle: String) {
        NetworkController.shared.fetchSearchMovie(apiKey: MovieApi.apiKey, language: MovieApi.language, movieTitle: movieTitle) { result in
            switch result {
            case .success(let movieList):
                
                //posterPath가 있는 데이터만 컬렉션뷰에 보이도록
                let list = movieList.filter { $0.posterPath != nil }
                self.movieArr = list
                
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                }
            case .failure(let error):
                print("영화 데이터를 가져오는데 실패했습니다.: \(error)")
            }
        }
    }
}
//MARK: - 서치바 만드는부분
extension MovieSearchViewController: UISearchBarDelegate {
    
    // 사용자가 검색 버튼을 눌렀을 때 호출되는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("검색어: \(searchText)")
            searchMovie(movieTitle: searchText)
        }
    }
    
    // 사용자가 검색 바에 텍스트를 입력할 때마다 호출되는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("실시간 입력된 검색어: \(searchText)")
        // 여기에서 실시간으로 입력된 검색어를 처리하거나 다른 동작을 수행할 수 있습니다.
    }
    //서치바 커스텀
    func searchbarchange1(){
        searchBar1.searchBarStyle = .minimal
        searchBar1.layer.cornerRadius = 20
        searchBar1.placeholder = "영화를 검색해 주세요"
        searchBar1.layer.masksToBounds = true
    }
}
