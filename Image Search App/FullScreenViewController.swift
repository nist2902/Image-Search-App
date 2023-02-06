//
//  FullScreenViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit

class FullScreenViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    
    var imageResult: ImagesResult!
    var position: Int!
    var imagesResults: [ImagesResult]!
//    var results: ImagesResult!

    // load image from imageResult.link
//    func configure(with imageResult: ImagesResult, at position: Int) {
//        self.imageResult = imageResult
//        self.position = position
//        guard let url = URL(string: imageResult.original) else {
//            return
//        }
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
//                self?.imageView.image = image
//            }
//        }.resume()
//    }
//
//    func loadImage() {
//        let url = URL(string: imageResult.thumbnail)!
//        let data = try? Data(contentsOf: url)
//        if let imageData = data {
//            imageView.image = UIImage(data: imageData)
//        }
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    func loadImage() {
        let url = URL(string: imageResult.thumbnail)!
        let data = try? Data(contentsOf: url)
        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if position < imagesResults.count - 1 {
            position += 1
            imageResult = imagesResults[position]
            loadImage()
        }
        
    }

    @IBAction func prevButtonTapped(_ sender: UIButton) {
        if position > 0 {
            position -= 1
            imageResult = imagesResults[position]
            loadImage()
        }
        
    }

    @IBAction func sourceButtonTapped(_ sender: UIButton) {
        // open source website in WebViewController
        
//        let fullScreenViewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//        let url = URL(string: imageResult.link)!
//        fullScreenViewController.configure(with: url)
//        navigationController?.pushViewController(fullScreenViewController, animated: true)
        let webVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webVC.url = URL(string: imageResult.link)!
            present(webVC, animated: true, completion: nil)
    }
}
