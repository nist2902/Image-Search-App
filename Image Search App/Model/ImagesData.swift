//
//  ImagesData.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import Foundation

struct APIResponse: Decodable {
    let images_results: [ImagesResult]
}

struct ImagesResult: Decodable, Equatable {
    var position: Int
    let link: String
    let thumbnail: String
    let original: String
}

