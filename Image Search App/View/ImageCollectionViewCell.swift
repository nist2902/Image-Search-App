//
//  ImageCollectionViewCell.swift
//  Image Search App
//
//  Created by Николай Стукало on 07.02.2023.
//

//import UIKit
//
//class ImageCollectionViewCell: UICollectionViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//}

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }

    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        loadImage(from: url)
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
}

