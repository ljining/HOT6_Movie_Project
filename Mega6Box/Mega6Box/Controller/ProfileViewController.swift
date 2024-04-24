//
//  ProfileViewController.swift
//  Mega6Box
//
//  Created by imhs on 4/24/24.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    var tempId: Int?
    var tempName: String?
    
    var castId: Int = 0
    var castName: String = ""
    
    //var person: Person?
    
    var profileView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - 프로필 사진
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - 이름
    var profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filmographyView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var filmographyLabel: UILabel = {
        let label = UILabel()
        label.text = "필모그래피"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filmographyTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let id = tempId, let name = tempName {
            castId = id
            castName = name
        }
        print("castId: \(castId), castName: \(castName)")
        
        setAutoLayout()
        setProfile(castId: castId, castName: castName)
    }
    
    // MARK: - 오토레이아웃 설정
    func setAutoLayout() {
        view.addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(profileNameLabel)
        
        view.addSubview(filmographyView)
        filmographyView.addSubview(filmographyLabel)
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            profileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            profileImageView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalTo: profileView.heightAnchor, multiplier: 0.7),
            profileImageView.widthAnchor.constraint(equalTo: profileView.widthAnchor, multiplier: 0.45),
            
            profileNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            profileNameLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            
            filmographyView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 5),
            filmographyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            filmographyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            filmographyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            filmographyLabel.topAnchor.constraint(equalTo: filmographyView.topAnchor, constant: 5),
            filmographyLabel.leadingAnchor.constraint(equalTo: filmographyView.leadingAnchor, constant: 10),
            filmographyLabel.trailingAnchor.constraint(equalTo: filmographyView.trailingAnchor, constant: -10),
            
//            filmographyCollectionView.topAnchor.constraint(equalTo: filmographyLabel.bottomAnchor, constant: 5),
//            filmographyCollectionView.leadingAnchor.constraint(equalTo: filmographyView.leadingAnchor, constant: 10),
//            filmographyCollectionView.trailingAnchor.constraint(equalTo: filmographyView.trailingAnchor, constant: -10),
//            filmographyCollectionView.bottomAnchor.constraint(equalTo: filmographyView.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - 프로필 가져오기
    func setProfile(castId: Int, castName: String) {
        NetworkController.shared.fetchSearchPerson(apiKey: MovieApi.apiKey, language: MovieApi.language, name: castName) { result in
            switch result {
            case .success(let data):
                print("프로필 가져오기")
                let profileData = data.filter({ $0.id == castId })
                print("profileData: \(profileData)")
                
                //self.person = profileData[0]
                
                if let profileImagePath = profileData[0].profilePath {
                    if let url = URL(string: "\(MovieApi.imageUrl)\(profileImagePath)") {
                        print(url)
                        DispatchQueue.main.async {
                            self.profileImageView.kf.setImage(with: url)
                            self.profileNameLabel.text = profileData[0].name
                        }
                    }
                }
                
            case .failure(let failure):
                print("failure: \(failure)")
            }
        }
        
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
