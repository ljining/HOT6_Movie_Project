//
//  BackDropCell.swift
//  Mega6Box
//
//  Created by 이유진 on 4/25/24.
//

import UIKit
import Kingfisher

class BackDropCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func setUpImage(input: String) {
        // String 타입의 input을 URL로 변환
        guard let url = URL(string: input) else {
            print("Invalid URL string: \(input)")
            return
        }

        // 변환된 URL을 사용하여 이미지 설정
        self.image.kf.setImage(with: url)
    }
}
