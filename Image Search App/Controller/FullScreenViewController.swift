//
//  FullScreenViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var currentImageResult: ImagesResult!
    var imagesResults: [ImagesResult]!
    var position: Int!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageView()
    }
    
    func updateImageView() {
        let url = URL(string: currentImageResult.thumbnail)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let imageData = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if position < imagesResults.count - 1 {
            currentImageResult = imagesResults[position + 1]
            updateImageView()
        }
    }

    @IBAction func prevButtonTapped(_ sender: UIButton) {
        if position > 0 {
            currentImageResult = imagesResults[position - 1]
            updateImageView()
        }
    }

    @IBAction func sourceButtonTapped(_ sender: UIButton) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webVC.url = URL(string: currentImageResult.link)!
            present(webVC, animated: true, completion: nil)
    }
}

