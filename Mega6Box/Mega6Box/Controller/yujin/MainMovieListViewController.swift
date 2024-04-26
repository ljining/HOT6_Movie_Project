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
    
    
    var banners: [String] = []
    var posters: [String] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        setupMovieImages(1)
        setupPosterImages(1)
        //bannerTimer()
        
        let layout =  UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 14 // 한 줄 내에서의 셀 간격
        
        
        posterCollectionView.collectionViewLayout = layout
        
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
            cell.layer.cornerRadius = 25
            cell.layer.masksToBounds = true
        }
        return print("")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return collectionView.bounds.size
        } else {
            let width: CGFloat = 135
            let height: CGFloat = 200
            return CGSize(width: width, height: height )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0.0
        } else if collectionView == posterCollectionView {
            return 10.0
        }
        return 10.0
    }
}

// MARK: - 이미지 요청
extension MainMovieListViewController {
    
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
                print("포스터 가져오기 성공")
                
            case .failure(let error):
                print("포스터 이미지 가져오기 실패: \(error)")
            }
        }
}
    
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
                print("포스터 가져오기 성공")
                
            case .failure(let error):
                print("포스터 이미지 가져오기 실패: \(error)")
            }
        }
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
