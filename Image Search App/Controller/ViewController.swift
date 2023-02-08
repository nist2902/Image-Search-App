//
//  ViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [ImagesResult] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: "ImageCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        let itemSize = (view.frame.width - 15) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionView.collectionViewLayout = layout
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

// MARK: Конфигурируем ячейку
extension ViewController: UICollectionViewDataSource {
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

// MARK: Переход по выбранной ячейке
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenVC = storyboard?.instantiateViewController(identifier: "FullScreenViewController") as! FullScreenViewController
        fullScreenVC.currentImageResult = photos[indexPath.row]
        fullScreenVC.position = indexPath.row
        fullScreenVC.imagesResults = photos
        navigationController?.show(fullScreenVC, sender: self)
    }
}

// MARK: Размер ячейки и расстояние между ними
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = (view.frame.width - 15) / 3
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: Работа со строкой поиска
extension ViewController: UISearchBarDelegate {
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .black
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            photos = []
            collectionView?.reloadData()
            fetchPhotos(for: text)
        }
    }
}
