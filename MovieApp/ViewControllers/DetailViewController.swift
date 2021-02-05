//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController{
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    var movie: Movie
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    var cell: MovieViewCell!
    var keyFirst = ""
    
    
    init(movie: Movie){
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        keyFirst = movie.title
        title = movie.title
        setUpData()
        checkClick()
    }
    
    func setUpData(){
       
        imageView.sd_setImage(with: URL(string: ApiRemote().urlPoster(path: movie.backdrop_path)), completed: nil)
        ratingLabel.text = "\(movie.vote_average)"
        descriptionLabel.text = movie.overview
        titleLabel.text = movie.title 
        releaseLabel.text = movie.release_date
    }
    
    func checkClick(){
        let isclicked = storeVal.bool(forKey: keyFirst)
                         if isclicked{
                           favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                           favButton.tintColor = .systemYellow
                                   
                        }else{
                           favButton.setImage(UIImage(systemName: "star"), for: .normal)
                           favButton.tintColor = .black
                        }
           
       }
    @IBAction func click(_ sender: UIButton) {
        let isclicked = storeVal.bool(forKey: keyFirst)
        if isclicked{
               favButton.setImage(UIImage(systemName: "star"), for: .normal)
                   favButton.tintColor = .black
                 storeVal.removeObject(forKey: keyFirst)
               }else{
                   storeVal.set(true, forKey: keyFirst)
                   favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                   favButton.tintColor = .systemYellow
               }
         
        NotificationCenter.default.post(name: NSNotification.Name(keyFirst), object: nil)
       
    }
}


