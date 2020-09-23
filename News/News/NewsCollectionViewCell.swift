//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Murat Merekov on 21.09.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    var photoImageView: UIImageView!
    var favoriteButton: UIButton!
    var newView: UIView!
    var ratingLabel: UILabel!
    let size:CGFloat = 54.0
    var ratingButton: UIButton!
    var viewRate: UIView!
     var movieName: UILabel!
      var movieDate: UILabel!
    let defaults = UserDefaults.standard
    let calling = "check"
    var flag = false
    var detail: Detail!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(hue: 229/360, saturation: 100/100, brightness: 52/100, alpha: 1.0)
        
        

        photoImageView = UIImageView(frame: .zero)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 140
        contentView.addSubview(photoImageView)
        
        
        newView = UIView()
        
        newView.translatesAutoresizingMaskIntoConstraints=false
        
        newView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        newView.isOpaque = false
        contentView.addSubview(newView)
        
        favoriteButton = UIButton()
              favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.isOpaque = false
                      
              favoriteButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
              newView.addSubview(favoriteButton)
        
       
  
       
        ratingButton = UIButton()
        ratingButton.translatesAutoresizingMaskIntoConstraints = false
        ratingButton.backgroundColor = .white
        ratingButton.frame = CGRect(x: 160, y: 100, width: 70, height: 70)
        NSLayoutConstraint.activate([
            ratingButton.heightAnchor.constraint(equalToConstant: 70),
            ratingButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        ratingButton.isOpaque = false
        newView.addSubview(ratingButton)
        
        movieName = UILabel()
               movieName.translatesAutoresizingMaskIntoConstraints = false
               movieName.font = UIFont.boldSystemFont(ofSize: 25)
        movieName.textColor = .white
               movieName.contentMode = .scaleAspectFit
               newView.addSubview(movieName)
 
        movieDate = UILabel()
                      movieDate.translatesAutoresizingMaskIntoConstraints = false
                      movieDate.font = UIFont.boldSystemFont(ofSize: 25)
        movieDate.textColor = .white
                      movieDate.contentMode = .scaleAspectFit
                      
                      newView.addSubview(movieDate)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            newView.topAnchor.constraint(equalTo: contentView.topAnchor),
            newView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: newView.topAnchor, constant: 30),
            favoriteButton.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -130),
            favoriteButton.heightAnchor.constraint(equalToConstant: 70),
            favoriteButton.widthAnchor.constraint(equalToConstant: 70),
            
            ratingButton.topAnchor.constraint(equalTo: newView.topAnchor, constant: 30),
            ratingButton.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant:130),
            
            movieName.centerXAnchor.constraint(equalTo: newView.centerXAnchor),
            movieName.centerYAnchor.constraint(equalTo: newView.centerYAnchor),
            movieDate.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 4),
            movieDate.centerXAnchor.constraint(equalTo: newView.centerXAnchor)
             
        
        ])
    }
    func configure(_ detail: Detail){
        self.detail = detail
        let check = defaults.bool(forKey: detail.title)
        
        if check{
            flag = true
            favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "rating"), for: .normal)

        }
        
        NetworkManager.getImage(imageURL: detail.poster_path) { (result) in
            self.photoImageView.image = result
        }
        
     
        ratingButton.setTitle("\(detail.vote_average)", for: .normal)
        ratingButton.setTitleColor(.black, for: .normal)
        ratingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        ratingButton.layer.cornerRadius = ratingButton.bounds.size.width/2
        
        movieName.text = detail.title
        movieDate.text = detail.release_date
    }
    @objc func favButtonPressed(){
        self.flag.toggle()
        if(flag){
        favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(named: "rating"), for: .normal)
        }
        defaults.set(flag, forKey: detail.title)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
