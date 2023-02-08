//
//  FullScreenViewController.swift
//  Image Search App
//
//  Created by Николай Стукало on 06.02.2023.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentImageResult: ImagesResult!
    var imagesResults: [ImagesResult]!
    var position: Int!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageView()
    }
    
    func updateImageView() {
        let url = URL(string: currentImageResult.original)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let imageData = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
        
        // Скрывает кнопку переключения если изображение первое/последнее
        position == 0 ? (prevButton.alpha = 0) : (prevButton.alpha = 1)
        position == imagesResults.count - 1 ? (nextButton.alpha = 0) : (nextButton.alpha = 1)
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if position < imagesResults.count - 1 {
            position += 1
            currentImageResult = imagesResults[position]
            updateImageView()
        }
    }

    @IBAction func prevButtonTapped(_ sender: UIButton) {
        if position > 0 {
            position -= 1
            currentImageResult = imagesResults[position]
            updateImageView()
        }
    }

    @IBAction func sourceButtonTapped(_ sender: UIButton) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webVC.url = URL(string: currentImageResult.link)!
            present(webVC, animated: true, completion: nil)
    }
}
