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
        setupMovieImages()
        //bannerTimer()
    }
    
}

// MARK: - Banner 컬렉션뷰 구현
extension MainMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return banners.count
        } else if collectionView == posterCollectionView {
            return 5
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
            let width: CGFloat = 133
            let height: CGFloat = 212
            return CGSize(width: width, height: height )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            return 0.0
        } else if collectionView == posterCollectionView {
            return 0.0
        }
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            // 위아래 여백 설정
            let verticalSpacing: CGFloat = 0.0
            return UIEdgeInsets(top: verticalSpacing, left: 0, bottom: verticalSpacing, right: 0)
        }
}

// MARK: - 이미지 요청
extension MainMovieListViewController {
    
    func setupMovieImages() {
        NetworkController.shared.fetchSearchMovieId(movieId: 838209, apiKey: MovieApi.apiKey, language: MovieApi.language) { result in
            switch result {
            case .success(let banner):
                break
//                print(banner[0].backdropPath!)
//                let x = banner[0].backdropPath!
//                let imageURL = "\(MovieApi.imageUrl)\(x)"
//                self.banners = [imageURL]
//                
                print("배너 이미지 가져오기 성공")
            case .failure(let error):
                print("배너 이미지를 가져오는 데 실패했습니다: \(error)")
                
            }
        }
    }
    
    func setupPosterImages(_ movieTitle: String) {
        NetworkController.shared.fetchSearchMovie(apiKey: MovieApi.apiKey, language: MovieApi.language, movieTitle: movieTitle) { result in
            switch result {
            case .success(let poster): break
//                print(poster[0])
//                let x = poster[0].posterPath
//                let imageURL = "\(MovieApi.imageUrl)\(x)"
//                self.posters = [imageURL]
//                print("포스터 가져오기 성공")
                
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
