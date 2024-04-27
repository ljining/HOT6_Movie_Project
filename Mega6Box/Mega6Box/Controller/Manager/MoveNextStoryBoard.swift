//
//  MoveNextStoryBoard.swift
//  Mega6Box
//
//  Created by 김태담 on 4/26/24.
//

import Foundation
import UIKit

class MoveNextStoryBoard{
    static let shared = MoveNextStoryBoard()
    //전달하는 무비아이디
    static var movieID = 0
    
    //ex)     MoveNextStoryBoard.shared.moveNext(storyboardName: "MovieDetail", viewControllerIdentifier: "MovieDetailViewController", from: self)
    func moveNext(storyboardName: String, viewControllerIdentifier: String, from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? UIViewController {
            viewController.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("Error: ViewController could not be instantiated or cast to UIViewController")
        }
    }
    
    func moveNext(storyboardName: String, viewControllerIdentifier: String, from viewController: UIViewController, movieID: Int) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let nextViewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? UIViewController {
            MoveNextStoryBoard.movieID = movieID
            viewController.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            print("Error: ViewController could not be instantiated or cast to UIViewController")
        }
    }
    
}
