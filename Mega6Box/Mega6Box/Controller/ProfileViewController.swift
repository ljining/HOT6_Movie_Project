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
    
    var person: Person?
    
    var profileView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - 프로필 사진
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        imageView.layer.borderWidth = 1
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
//        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var filmographyLabel: UILabel = {
        let label = UILabel()
        label.text = "필모그래피"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var filmographyTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1)
        tableView.layer.cornerRadius = 20
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        filmographyTableView.dataSource = self
        filmographyTableView.delegate = self
        
        if let id = tempId, let name = tempName {
            castId = id
            castName = name
        }
        print("castId: \(castId), castName: \(castName)")
        
        setAutoLayout()
        setProfile(castId: castId, castName: castName)
        
        filmographyTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - 오토레이아웃 설정
    func setAutoLayout() {
        view.addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(profileNameLabel)
        
        view.addSubview(filmographyView)
        filmographyView.addSubview(filmographyLabel)
        filmographyView.addSubview(filmographyTableView)
        
        
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
            
            filmographyTableView.topAnchor.constraint(equalTo: filmographyLabel.bottomAnchor, constant: 5),
            filmographyTableView.leadingAnchor.constraint(equalTo: filmographyView.leadingAnchor),
            filmographyTableView.trailingAnchor.constraint(equalTo: filmographyView.trailingAnchor),
            filmographyTableView.bottomAnchor.constraint(equalTo: filmographyView.bottomAnchor),
            
        ])
    }
    
    // MARK: - 프로필 가져오기
    func setProfile(castId: Int, castName: String) {
        //api를 요청하고 성공하면 아래 중괄호로 구조체로 정의한 형식의 데이터가 반환됩니다.
        NetworkController.shared.fetchSearchPerson(apiKey: MovieApi.apiKey, language: MovieApi.language, name: castName) { result in
            
            switch result {
            case .success(let data):    //데이터는 구조체 이름인데 사용자가 마음대로 설정할 수 있습니다.
                
                //이름으로 검색해야하는데 동명이인이 있어 유일키인 ID값으로 추가
                let profileData = data.filter({ $0.id == castId })
                
                self.person = profileData[0]
                
                if let profileImagePath = profileData[0].profilePath {
                    if let url = URL(string: "\(MovieApi.imageUrl)\(profileImagePath)") {
                        
                        DispatchQueue.main.async {
                            self.profileImageView.kf.setImage(with: url)
                            self.profileNameLabel.text = profileData[0].name
                        }
                    }
                }
                
            case .failure(let failure):
                print("프로필 이미지 가져오기 실패: \(failure)")
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = person?.knownFor.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1)

        if let posterPath = person?.knownFor[indexPath.row].posterPath {
            if let url = URL(string: "\(MovieApi.imageUrl)\(posterPath)") {
                DispatchQueue.main.async {
                    cell.posterImageView.kf.setImage(with: url) //포스터
                    cell.movieTitleLabel.text = self.person?.knownFor[indexPath.row].title ?? self.person?.knownFor[indexPath.row].name //영화명, title이 옵셔널이라 name까지 추가
                    if let releaseDate = self.person?.knownFor[indexPath.row].releaseDate {
                        cell.movieReleaseDateLabel.text = "\(releaseDate) 개봉"   //개봉일
                    }
                    cell.overviewTextView.text = self.person?.knownFor[indexPath.row].overview  //줄거리
                }
            }
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
