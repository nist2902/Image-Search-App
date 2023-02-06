//
//  ViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit

struct APIResponse: Decodable {
    let images_results: [ImagesResult]
}

struct ImagesResult: Decodable {
    var position: Int
    let link: String
    let thumbnail: String
}


class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    var search: Bool = false
    var results: [ImagesResult] = []
    
    let searchBar = UISearchBar()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.addSubview(searchBar)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        self.collectionView = collectionView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.width-20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.frame.size.width, height: view.frame.size.width-55)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            collectionView?.reloadData()
            fetchPhotos(query: text)
        }
    }
    
    func fetchPhotos(query: String) {
        
        //Здесь неоходимо ввести свой API ключ serpapi.com или использовать мой для проверки работы
        //Мой ключ "13ee4ef85881e4450b90e7ab810a8e9ef9ec42cb1bf517ee5ee688cee1c2ea80"
        let APIKey = "13ee4ef85881e4450b90e7ab810a8e9ef9ec42cb1bf517ee5ee688cee1c2ea80"
//        let APIKey = "Enter your API key here"

        let urlString = "https://serpapi.com/search.json?&q=\(query)&tbm=isch&ijn=0&api_key=\(APIKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            print("Got data!")
            print(data)
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.images_results
                    self?.collectionView?.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("----- \(results.count)")
        return results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].thumbnail
        print(imageURLString)
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCollectionViewCell.identifier,
            for: indexPath
        ) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: imageURLString)
        return cell
    }
}
