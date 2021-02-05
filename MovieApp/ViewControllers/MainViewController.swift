//
//  MainViewController.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit


var storeVal = UserDefaults.standard

var glob_movie: Movie!
class MainViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [Movie]()
    var page = 1
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        
        setupCollectionView()
        loadMoreData()
        setupRefresh()
    }
    
    func setupRefresh(){
           refresher = UIRefreshControl()
           collectionView.alwaysBounceVertical = true
        
            refresher.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
           refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
           collectionView.addSubview(refresher!)
    }
    
    @objc func loadData() {
        page = 1
        movies.removeAll()
        loadMoreData()
        collectionView.reloadData()
        stopRefresher()
     }

    func stopRefresher() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refresher.endRefreshing()
        }
     }
    func setupCollectionView(){
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.register(UINib(nibName: "MovieViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MovieViewCell")
       }
    
    
       
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        
        cell.bindData(movie: movies[indexPath.row])
        cell.cornerRadius = 20
        return cell
    }
  
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        
        let detailVC = DetailViewController(movie: movies[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
               if indexPath.row == movies.count - 1 {  //numberofitem count
                   loadMoreData()
               }
       }
    
    func loadMoreData(){
        NetworkManager.shared.get(url: ApiRemote().urlMovie() ,params:["api_key":"8b82f416093cf29ab75ae07cc5b416dd","page":page]) { (result: Result<Data,Error>) in
             switch result{
               case .success(let result):
                    print(result)
                    self.movies.append(contentsOf: result.results)
                   
                   DispatchQueue.main.async{
                        self.collectionView.reloadData()
                    }
              case .failure(_):
                print(" \n error hetting data! \n")
                   
           }
        }
        page += 1
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width-15
        let height = collectionView.frame.size.height/1.5
        
        return CGSize(width: width, height: height)
    
    }
}


