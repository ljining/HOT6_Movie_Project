//
//  MovieListCollectionViewCell.swift
//  Mega6Box
//
//  Created by 이유진 on 4/23/24.
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImages: UIImageView!
    @IBOutlet weak var gradient: UIImageView!
    @IBOutlet weak var voteBtn: UIButton!
    
    
    var id: Int = 0
    weak var viewController: UIViewController?
    
    func setUpPoster(input: String) {
        guard let url = URL(string: input) else {
            print("")
            return
        }
        self.posterImages.kf.setImage(with: url)
    }
    
    // MARK: - 예매 페이지로 이동
    @IBAction func tapVoteBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "MovieReservationPage", bundle: Bundle.main)
        guard let reservationVC = storyboard.instantiateViewController(withIdentifier: "MoiveReservationViewController") as? MoiveReservationViewController else { return }
            
        reservationVC.tempMovieId = sender.tag
        
        viewController?.present(reservationVC, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // PosterImage CornerRadius
        self.posterImages.layer.cornerRadius = 20
        
        // Gradient Effect
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradient.bounds.width, height: gradient.bounds.height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.9).cgColor] // 투명에서 검정으로 그라디언트 색상 설정
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.gradient.layer.cornerRadius = 20
        
        // 이미지뷰에 그라디언트 레이어 추가
        gradient.layer.addSublayer(gradientLayer)
    }
}
