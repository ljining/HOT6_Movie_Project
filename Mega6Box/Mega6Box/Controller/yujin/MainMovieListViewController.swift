//
//  MainMovieListViewController.swift
//  Mega6Box
//
//  Created by 이유진 on 4/23/24.
//

import UIKit
import Kingfisher

class MainMovieListViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    @IBOutlet weak var nowPlaying: UILabel!
    
    @IBOutlet weak var eventButton1: UIButton!
    @IBOutlet weak var eventButton2: UIButton!
    @IBOutlet weak var eventButton3: UIButton!
    @IBOutlet weak var eventButton4: UIButton!
    
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var reservButton: UIButton!
    @IBOutlet weak var myPageButton: UIButton!
    
    var banners: [String] = []
    var posters: [String] = []
    
    // MARK: - Button 클릭 시 화면 이동
    
    @IBAction func moveToSearchPage(_ sender: Any) {

                let storyboard = UIStoryboard(name: "SearchView", bundle: Bundle.main)
                   guard let reservationVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController  else {
                       print("Could not instantiate MovieReservationViewController from storyboard.")
                       return
                   }
                   self.present(reservationVC, animated: true)
            }
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        setupMovieImages(1)
        setupPosterImages(1)
        setupUI()
        //bannerTimer()
        
    }
    
}

// MARK: - Banner 컬렉션뷰 구현
extension MainMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return banners.count
        } else if collectionView == posterCollectionView {
            return posters.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BackDropCell
            cell.setUpImage(input: banners[indexPath.row])
            //setupMovieImages()
            return cell
        } else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCollectionViewCell
            cell2.setUpPoster(input: posters[indexPath.row])
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView {
            pageControl.currentPage = indexPath.row
        } else if collectionView == posterCollectionView {
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowOpacity = 0.3
            cell.layer.shadowRadius = 4
        }
        return print("")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return collectionView.bounds.size
        } else {
            let width: CGFloat = 135
            let height: CGFloat = 220
            return CGSize(width: width, height: height )
        }
    }
}

// MARK: - 이미지 요청
extension MainMovieListViewController {
    
    // (Top) 배너 이미지 요청
    func setupMovieImages(_ page: Int) {
        NetworkController.shared.fetchMovieNowPlaying(apiKey: MovieApi.apiKey, language: MovieApi.language, region: MovieApi.region, page: page) { result in
            switch result {
            case .success(let banner):
                
                print(banner[0])
                
                let image = banner[0]
                for image in banner {
                    if let bannerImagePath = image.backdropPath,
                       let url = URL(string: "\(MovieApi.imageUrl)\(bannerImagePath)") {
                        self.banners += [url.absoluteString]
                    }
                }
                
                DispatchQueue.main.async {
                    self.posterCollectionView.reloadData()
                }
                print("배너 이미지 가져오기 성공")
                
            case .failure(let error):
                print("배너 이미지 가져오기 실패: \(error)")
            }
        }
    }
    // (Bottom) 포스터 이미지 요청
    func setupPosterImages(_ page: Int) {
        NetworkController.shared.fetchMovieNowPlaying(apiKey: MovieApi.apiKey, language: MovieApi.language, region: MovieApi.region, page: page) { result in
            switch result {
            case .success(let poster):
                
                print(poster[0])
                
                let image = poster[0]
                for image in poster {
                    if let posterImagePath = image.posterPath,
                       let url = URL(string: "\(MovieApi.imageUrl)\(posterImagePath)") {
                        self.posters += [url.absoluteString]
                    }
                }
                
                DispatchQueue.main.async {
                    self.posterCollectionView.reloadData()
                }
                print("포스터 이미지 가져오기 성공")
                
            case .failure(let error):
                print("포스터 이미지 가져오기 실패: \(error)")
            }
        }
    }
}

// MARK: -
extension MainMovieListViewController {
    
    func setupUI() {
        // PosterCollectionView UI
        let layout =  UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 14
        posterCollectionView.collectionViewLayout = layout
    
        
        // 현재 상영작 Label UI
        nowPlaying.layer.shadowColor = UIColor.black.cgColor
        nowPlaying.layer.shadowOffset = CGSize(width: 0, height: 2)
        nowPlaying.layer.shadowOpacity = 0.4
        nowPlaying.layer.shadowRadius = 4
        
        // EventButton UI
        eventButton1.layer.shadowColor = UIColor.black.cgColor
        eventButton1.layer.shadowOffset = CGSize(width: 0, height: 2)
        eventButton1.layer.shadowOpacity = 0.4
        eventButton1.layer.shadowRadius = 4
        
        eventButton2.layer.shadowColor = UIColor.black.cgColor
        eventButton2.layer.shadowOffset = CGSize(width: 0, height: 2)
        eventButton2.layer.shadowOpacity = 0.4
        eventButton2.layer.shadowRadius = 4
        
        eventButton3.layer.shadowColor = UIColor.black.cgColor
        eventButton3.layer.shadowOffset = CGSize(width: 0, height: 2)
        eventButton3.layer.shadowOpacity = 0.4
        eventButton3.layer.shadowRadius = 4
        
        eventButton4.layer.shadowColor = UIColor.black.cgColor
        eventButton4.layer.shadowOffset = CGSize(width: 0, height: 2)
        eventButton4.layer.shadowOpacity = 0.4
        eventButton4.layer.shadowRadius = 4
        
        // Page Button UI
        homeButton.layer.shadowColor = UIColor.black.cgColor
        homeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        homeButton.layer.shadowOpacity = 0.4
        homeButton.layer.shadowRadius = 4
        
        reservButton.layer.shadowColor = UIColor.black.cgColor
        reservButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        reservButton.layer.shadowOpacity = 0.4
        reservButton.layer.shadowRadius = 4
        
        myPageButton.layer.shadowColor = UIColor.black.cgColor
        myPageButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        myPageButton.layer.shadowOpacity = 0.4
        myPageButton.layer.shadowRadius = 4
        
    }
}

// MARK: -
//extension MainMovieListViewController {
//
//    // 2초마다 실행되는 타이머
//    func bannerTimer() {
//        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
//            self.bannerMove()
//        }
//    }
//    // 배너 움직이는 매서드
//    func bannerMove() {
//        // 현재페이지가 마지막 페이지일 경우
//        if currentPage == movieImages.count-1 {
//            // 맨 처음 페이지로 돌아감
//            BannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
//            currentPage = 0
//            return
//        }
//        // 다음 페이지로 전환
//        currentPage += 1
//        BannerCollectionView.scrollToItem(at: NSIndexPath(item: currentPage, section: 0) as IndexPath, at: .right, animated: true)
//    }
//
//}
