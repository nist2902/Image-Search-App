//
//  ViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var results: [ImagesResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }

    // perform search based on search text
//    func search(for text: String) {
//        // perform search and update apiResponse
//    }
    
    func fetchPhotos(for query: String) {
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
}


// Extension for UICollectionViewDataSource
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].thumbnail
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
                fullScreenVC.imageResult = results[indexPath.row]
                fullScreenVC.position = indexPath.row
                fullScreenVC.imagesResults = results
                navigationController?.show(fullScreenVC, sender: self)
    }
}

// Extension for UISearchBarDelegate
extension ViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            collectionView?.reloadData()
            fetchPhotos(for: text)
        }
    }
}
