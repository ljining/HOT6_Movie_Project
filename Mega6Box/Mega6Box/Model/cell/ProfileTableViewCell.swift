//
//  ProfileTableViewCell.swift
//  Mega6Box
//
//  Created by imhs on 4/24/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - 포스터 이미지
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - 영화제목
    var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 개봉일
    var movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 줄거리
    var overviewTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.backgroundColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    // MARK: - 초기화 메서드 오버라이드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieReleaseDateLabel)
        contentView.addSubview(overviewTextView)
                
        NSLayoutConstraint.activate([
            // MARK: - 포스터 이미지
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            
            // MARK: - 영화 제목
            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            
            // MARK: - 개봉일
            movieReleaseDateLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.trailingAnchor, constant: 10),            
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            // MARK: - 줄거리 
            overviewTextView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            overviewTextView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            overviewTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            overviewTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
