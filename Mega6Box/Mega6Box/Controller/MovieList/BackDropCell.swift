//
//  BackDropCell.swift
//  Mega6Box
//
//  Created by 이유진 on 4/25/24.
//

import UIKit

class BackDropCell: UICollectionViewCell {
    
    @IBOutlet weak var backDropImage: UIImageView!
    
    func setUpImage(input: String) {
        
        guard let url = URL(string: input) else {
            print("")
            return
        }
        self.backDropImage.kf.setImage(with: url)
    }
}
