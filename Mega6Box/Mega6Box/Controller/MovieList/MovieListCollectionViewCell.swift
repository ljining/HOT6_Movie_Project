//
//  MovieListCollectionViewCell.swift
//  Mega6Box
//
//  Created by 이유진 on 4/23/24.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    
    static let id = "MovieListCell"
    
    // Test Data
    private let testData: Data? = {
        let testString = "Test Data"
        return testString.data(using: .utf8)
    }()
    
    // MARK: - UI
    private let posterButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Set Button
        // Button Background Image
//        if let imageData = data, let backgroundImage = UIImage(data: imageData) {
//            button.setBackgroundImage(backgroundImage, for: .normal)
//        }
        
        // Button Rounded Corner
        button.layer.cornerRadius = 25
        
        // Button Size
        let buttonSize = CGSize(width: 133, height: 212)
        button.frame.size = buttonSize
        
        return button
    }()
    
    // MARK: - Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.contentView.addSubview(self.posterButton)
        NSLayoutConstraint.activate([
            self.posterButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.posterButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.posterButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.posterButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        ])
        
//        if let data = data, let testImage = UIImage(data: data) {
//            self.posterButton.set
//        }
    }
    

}
