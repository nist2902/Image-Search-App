////
////  NetworkManager.swift
////  Image Search App
////
////  Created by Николай Стукало on 06.02.2023.
////
//
//import Foundation
//
//class NetworkManager: ObservableObject {
//    
//    var results = [ImagesResult]()
//    var query: String = "Apple"
//    
//    func fetchData() {
//        if let url = URL(string: "https://serpapi.com/search.json?&q=\(query)&tbm=isch") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, URLResponse, error) in
//                if error == nil {
//                    let decoder = JSONDecoder()
//                    if let safeData = data {
//                        do {
//                            let results = try decoder.decode(Results.self, from: safeData)
//                            DispatchQueue.main.async {
//                                self.results = results.images_results
//                            }
//                        } catch {
//                            print(error)
//                            print(url)
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//}
//
////protocol CoinManagerDelegate {
////    func didUpdateCurrency(coin: CoinData)
////    func didFailWithError(error: Error)
////}
//
//struct NetworkManager {
////    var delegate: CoinManagerDelegate?
//
////    let baseURL = "https://serpapi.com/search.json?&q=\(query)&tbm=isch"
//    var query: String = "Apple"
//
//    func getImagesResult(for query: String) {
//        let urlString = "https://serpapi.com/search.json?&q=\(query)&tbm=isch"
//        performRequest(with: urlString)
//    }
//    
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString) {
//            
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
////                    self.delegate?.didFailWithError(error: error!)
//                    print(error)
//                    return
//                }
//                
//                if let safeData = data {
//                    if let coin = self.parseJSON(safeData) {
//                        self.delegate?.didUpdateCurrency(coin: coin)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    
//    func parseJSON(_ data: Data) -> ImagesResult? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(ImagesResult.self, from: data)
//            let position = decodedData.position
//            let link = decodedData.link
//            let thumbnail = decodedData.thumbnail
//            let result = ImagesResult(position: position, link: link, thumbnail: thumbnail)
//            return result
//        } catch {
////            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//    
//}
