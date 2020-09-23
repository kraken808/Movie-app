//
//  ViewController.swift
//  News
//
//  Created by Murat Merekov on 21.09.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    let reuseIdentifier = "newsCollectionCell"
    var movieList = [Detail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        navigationController?.navigationBar.barTintColor = UIColor(hue: 229/360, saturation: 100/100, brightness: 52/100, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = UIColor(hue: 229/360, saturation: 100/100, brightness: 52/100, alpha:1.0)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.refreshControl = refreshControl
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        getMovies()
        setupConstraints()
    }
    
    func setupConstraints(){
           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
           ])
       }
    @objc func pulledToRefresh(){
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               self.refreshControl.endRefreshing()
           }
       }
    func getMovies(){
        NetworkManager.getNews { (snapShot) in
            self.movieList = snapShot
            DispatchQueue.main.async {
                   self.collectionView.reloadData()
                 }
        }
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = movieList[indexPath.item]
        self.navigationController?.pushViewController(InfoViewController(detail: detail), animated: true)
       
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCollectionViewCell
        let detail = movieList[indexPath.item]
        cell.configure(detail)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width + 200 )
        return CGSize(width: length, height: length )
    }
  
}
