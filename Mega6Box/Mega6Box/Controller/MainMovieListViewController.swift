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
    @IBOutlet weak var backDropImage: UIImageView!
    
    var poster: [Movie] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        
        //bannerTimer()
    }
    
}

// MARK: - Banner 컬렉션뷰 구현
extension MainMovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BackDropCell
        
        setupMovieImages()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

// MARK: -
extension MainMovieListViewController {
    func setupMovieImages() {
        NetworkController.shared.fetchSearchMovieId(movieId: 838209, apiKey: MovieApi.apiKey, language: MovieApi.language) { result in
            switch result {
            case .success(let banner):
                self.poster = Array(banner.prefix(5))
                
                
                DispatchQueue.main.async {
                    // 배열 안의 각 이미지 URL을 사용하여 배너 이미지를 설정합니다.
                    for posterImage in self.poster {
                        let backdropPath = posterImage.backdropPath
                           let imageURL = URL(string: "\(MovieApi.imageUrl)\(backdropPath)")
                            // Kingfisher를 사용하여 이미지를 비동기적으로 설정합니다.
                        self.backDropImage.kf.setImage(with: imageURL)
                    }
                }
                
            case .failure(let error):
                print("배너 이미지를 가져오는 데 실패했습니다: \(error)")
                
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
