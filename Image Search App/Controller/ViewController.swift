//
//  ViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//
//TODO:
//Add loading process or just simple loading animation
//Add correct Segues
//Add Correct custom cell
//Add Comments and Marks
//Refactor
//MVC
//Improve UI
//Add Readme and .gitignore

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [ImagesResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }
    
    func fetchPhotos(for query: String) {
        APIManager.shared.fetchPhotos(for: query) { [weak self] result in
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                    self?.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// Extension for UICollectionViewDataSource
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = photos[indexPath.row].thumbnail
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageCollectionViewCell",
            for: indexPath
        ) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: imageURLString)
        return cell
    }
}

// Extension for UICollectionViewDelegate
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenVC = storyboard?.instantiateViewController(identifier: "FullScreenViewController") as! FullScreenViewController
        fullScreenVC.currentImageResult = photos[indexPath.row]
        fullScreenVC.position = indexPath.row
        fullScreenVC.imagesResults = photos
        navigationController?.show(fullScreenVC, sender: self)
    }
}

// Extension for UISearchBarDelegate
extension ViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            photos = []
            collectionView?.reloadData()
            fetchPhotos(for: text)
        }
    }
}
