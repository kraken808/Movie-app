//
//  MovieViewCell.swift
//  MovieNews
//
//  Created by Murat Merekov on 03.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import SDWebImage

class MovieViewCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: Movie!
    var keyFirst = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
    }
    
    func bindData(movie: Movie){
        self.movie = movie
        keyFirst = movie.title
        imageView.sd_setImage(with: URL(string: ApiRemote().urlPoster(path: movie.backdrop_path)), completed: nil)
        ratingLabel.text = "\(movie.vote_average)"
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        checkFavButton()
        setupNotification()
    }
    
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: movie.title), object: nil)
    }
    func checkFavButton(){
        let isclicked = storeVal.bool(forKey: keyFirst)
                if isclicked{
                    
                  self.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                  self.favoriteButton.tintColor = .systemYellow
                              
                  }else{
                             
                  self.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                  self.favoriteButton.tintColor = .black
         }
    }
    
    @objc func loadList(notification: NSNotification) {
        checkFavButton()
    }
    
    @IBAction func favouriteClicked(_ sender: UIButton) {
        changeButton()
    }
    
    func changeButton(){
        let isclicked = storeVal.bool(forKey: keyFirst)
               
               if isclicked{
                   
                   storeVal.removeObject(forKey: keyFirst)
                   self.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                   self.favoriteButton.tintColor = .black
               }else{
                   storeVal.set(true, forKey: keyFirst)
                   self.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                   self.favoriteButton.tintColor = .systemYellow
               }
              print(storeVal.bool(forKey: keyFirst))
    }
    
    
}
