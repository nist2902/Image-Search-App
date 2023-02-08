//
//  APIManager.swift
//  Image Search App
//
//  Created by Николай Стукало on 07.02.2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func fetchPhotos(for query: String, completion: @escaping (Result<[ImagesResult], Error>) -> Void) {
        // Здесь неоходимо ввести свой API ключ serpapi.com или использовать мой для проверки работы
        // let APIKey = "Enter your API key here"
        // Мой ключ "13ee4ef85881e4450b90e7ab810a8e9ef9ec42cb1bf517ee5ee688cee1c2ea80"
        let APIKey = "13ee4ef85881e4450b90e7ab810a8e9ef9ec42cb1bf517ee5ee688cee1c2ea80"
        
        // Если поисковый запрос приходит на русском языке, то кодируем его чтобы сформировать корректный URL
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        let urlString = "https://serpapi.com/search.json?&q=\(encodedQuery)&tbm=isch&ijn=0&api_key=\(APIKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.networkError))
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(jsonResult.images_results))
            } catch {
                completion(.failure(NetworkingError.decodingError))
            }
        }
        task.resume()
    }
}

enum NetworkingError: Error {
    case invalidURL
    case networkError
    case decodingError
}
