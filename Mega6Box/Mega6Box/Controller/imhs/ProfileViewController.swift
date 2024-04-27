//
//  ProfileViewController.swift
//  Mega6Box
//
//  Created by imhs on 4/24/24.
//

import UIKit
import Kingfisher

// MARK: - 배우 정보 확인
class ProfileViewController: UIViewController {
    var tempId: Int?            //이전 페이지에서 넘겨주는 배우ID값을 담을 변수
    var tempName: String?       //이전 페이지에서 넘겨주는 배우이름값을 담을 변수
    
    var castId: Int = 0         //배우 ID
    var castName: String = ""   //배우 이름
    
    var person: Person?         //TMDB받아온 데이터를 담을 구조체 타입 변수
    
    // MARK: - 프로필 사진과 이름이 담기는 뷰
    var profileView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - 배우 프로필 사진
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - 배우 이름
    var profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 필모그래피, 테이블 뷰가 담길 뷰
    var filmographyView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - 필모그래피 레이블
    var filmographyLabel: UILabel = {
        let label = UILabel()
        label.text = "필모그래피"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 0.4705 , green: 0.2627, blue: 0.902, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 필모그래피 테이블 뷰
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
        
        // MARK: - 이전 뷰 컨트롤러에서 받아오는 데이터를 변수에 할당
        if let id = tempId, let name = tempName {
            castId = id
            castName = name
        }
        print("받아온 데이터 castId: \(castId), castName: \(castName)")
        
        setAutoLayout()     //오토레이아웃 설정
        
        setProfile(castId: castId, castName: castName)  //배우 정보 가져오기
        
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
        NetworkController.shared.fetchSearchPerson(apiKey: MovieApi.apiKey, language: MovieApi.language, name: castName) { result in
            
            switch result {
            case .success(let person):
                
                //이름으로 검색해야하는데 동명이인이 있어 유일키인 ID값으로 추가
                let profileData = person.filter({ $0.id == castId })
                
                //테이블 뷰에 데이터를 보여주기 위해 데이터 할당
                self.person = profileData[0]
                
                if let profileImagePath = profileData[0].profilePath {
                    if let url = URL(string: "\(MovieApi.imageUrl)\(profileImagePath)") {
                        
                        DispatchQueue.main.async {
                            self.profileImageView.kf.setImage(with: url)        //배우 프로필 사진
                            self.profileNameLabel.text = profileData[0].name    //배우 이름
                            self.filmographyTableView.reloadData()
                        }
                    }
                }
            case .failure(let failure):
                print("프로필 정보 가져오기 실패: \(failure)")
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
