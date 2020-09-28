//
//  MainViewController.swift
//  Networking
//
//  Created by Eugene Kiselev on 28.09.2020.
//

import UIKit

private let reuseIdentifier = "Cell"
private let url = "https://jsonplaceholder.typicode.com/posts"
private let uploadImage = "https://api.imgur.com/3/image"

class MainViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager.shared
    private let actions = ["Download Image", "GET", "POST", "Our Courses", "Upload Image"]

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        cell.nameLabel.text = actions[indexPath.row]
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case "Download Image":
            performSegue(withIdentifier: "ShowImage", sender: self)
        case "GET":
            networkManager.getRequest(url: url)
        case "POST":
            networkManager.postRequest(url: url)
        case "Our Courses":
            performSegue(withIdentifier: "OurCourses", sender: self)
        case "Upload Image":
            networkManager.uploadImage(url: uploadImage)
        default:
            break
        }
    }
}
