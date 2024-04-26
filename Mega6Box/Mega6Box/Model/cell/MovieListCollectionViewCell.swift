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
    
    
    func setUpPoster(input: String) {
        guard let url = URL(string: input) else {
            print("")
            return
        }
        self.posterImages.kf.setImage(with: url)
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
