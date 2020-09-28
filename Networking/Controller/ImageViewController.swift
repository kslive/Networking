//
//  ImageViewController.swift
//  DownloadImage
//
//  Created by Eugene Kiselev on 25.09.2020.
//

import UIKit

class ImageViewController: UIViewController {

    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let networkManager = NetworkManager.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        fetchImage()
    }
    
    func fetchImage() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        networkManager.downloadImage(url: url) { [weak self] image in
            
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
}

