//
//  InfoViewController.swift
//  News
//
//  Created by Murat Merekov on 22.09.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import AVFoundation
class InfoViewController: UIViewController {
    var detail: Detail
    var imageView: UIImageView!
    var textField: UITextView!
    var ratingButton: UIButton!
    var favoriteButton: UIButton!
    var newView: UIView!
    var movieName: UILabel!
    var movieDate: UILabel!
    let defaults = UserDefaults.standard
       let calling = "check"
       var flag = false
    var fav:ViewController!
   init(detail: Detail) {
    self.detail = detail
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(detail.title)"
        
        view.backgroundColor = UIColor(hue: 229/360, saturation: 100/100, brightness: 52/100, alpha: 1.0)
       imageView = UIImageView()
         NetworkManager.getImage(imageURL: detail.backdrop_path) { (result) in
                   self.imageView.image = result
               }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
       
        newView = UIView()
               newView.translatesAutoresizingMaskIntoConstraints=false
               
               newView.isOpaque = false
               view.addSubview(newView)
               
               favoriteButton = UIButton()
                     favoriteButton.translatesAutoresizingMaskIntoConstraints = false
               
               favoriteButton.isOpaque = false
                     favoriteButton.setImage(UIImage(named: "rating"), for: .normal)
               
                     favoriteButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
                     newView.addSubview(favoriteButton)
        
        
        ratingButton = UIButton()
         checkFlag()
        ratingButton.translatesAutoresizingMaskIntoConstraints = false
        ratingButton.backgroundColor = .white
        ratingButton.frame = CGRect(x: 160, y: 100, width: 70, height: 70)
        NSLayoutConstraint.activate([
            ratingButton.heightAnchor.constraint(equalToConstant: 70),
            ratingButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        ratingButton.setTitle("\(detail.vote_average)", for: .normal)
        ratingButton.setTitleColor(.black, for: .normal)
        ratingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        ratingButton.layer.cornerRadius = ratingButton.bounds.size.width/2
        ratingButton.isOpaque = false
        newView.addSubview(ratingButton)
        
        textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(hue: 229/360, saturation: 100/100, brightness: 52/100, alpha: 1.0)
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.isEditable = false
        textField.contentMode = .scaleAspectFit
        textField.insertText(detail.overview)
        view.addSubview(textField)
        
        movieName = UILabel()
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieName.font = UIFont.boldSystemFont(ofSize: 20)
        movieName.backgroundColor = .white
        movieName.contentMode = .scaleAspectFit
        movieName.text = detail.title
        newView.addSubview(movieName)
        
        movieDate = UILabel()
               movieDate.translatesAutoresizingMaskIntoConstraints = false
               movieDate.font = UIFont.boldSystemFont(ofSize: 20)
        movieDate.backgroundColor = .white
        
               movieDate.contentMode = .scaleAspectFit
               movieDate.text = detail.release_date
               newView.addSubview(movieDate)
        setupConstraint()
    }
    func setupConstraint(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            newView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: newView.topAnchor, constant: 30),
            favoriteButton.trailingAnchor.constraint(equalTo: newView.trailingAnchor, constant: -15),
            favoriteButton.heightAnchor.constraint(equalToConstant: 70),
            favoriteButton.widthAnchor.constraint(equalToConstant: 70),
            
            ratingButton.topAnchor.constraint(equalTo: newView.topAnchor, constant: 30),
            ratingButton.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant:15),
            
            movieName.topAnchor.constraint(equalTo: ratingButton.bottomAnchor, constant: 120),
            movieName.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 10),
           
            
            movieDate.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 5),
            movieDate.leadingAnchor.constraint(equalTo: newView.leadingAnchor, constant: 10),
        
            
            
        ])
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
    func checkFlag(){
        let check = defaults.bool(forKey: detail.title)
        
        if check{
            flag = true
            favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        }else{
             favoriteButton.setImage(UIImage(named: "rating"), for: .normal)
        }
    }

}
