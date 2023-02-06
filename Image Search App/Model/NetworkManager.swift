////
////  NetworkManager.swift
////  Image Search App
////
////  Created by Николай Стукало on 06.02.2023.
////
//
//import Foundation
//
//class NetworkManager {
//    
//    func fetchPhotos(query: String) {
//        //Здесь неоходимо ввести свой API ключ serpapi.com или использовать мой для проверки работы
//        //Мой ключ "13ee4ef85881e4450b90e7ab810a8e9ef9ec42cb1bf517ee5ee688cee1c2ea80"
//        let APIKey = "13ee4ef85881e4450b90e7ab810a8e9ef9ec42cb1bf517ee5ee688cee1c2ea80"
////        let APIKey = "Enter your API key here"
//
//        let urlString = "https://serpapi.com/search.json?&q=\(query)&tbm=isch&ijn=0&api_key=\(APIKey)"
//        
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            print("Got data!")
//            print(data)
//            do {
//                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self?.results = jsonResult.images_results
//                    self?.collectionView?.reloadData()
//                }
//            }
//            catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
//}
