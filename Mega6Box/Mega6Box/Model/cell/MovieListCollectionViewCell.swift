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
    @IBAction func tapVoteBtn(_ sender: Any) {
        print(id)
        //프린트 대신 이동
        let storyboard = UIStoryboard(name: "myPage", bundle: Bundle.main)
           guard let reservationVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController  else {
               print("Could not instantiate MovieReservationViewController from storyboard.")
               return
           }
           viewController?.present(reservationVC, animated: true)
    }
}
