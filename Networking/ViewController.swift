//
//  ViewController.swift
//  Networking
//
//  Created by Eugene Kiselev on 25.09.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func getRequest(_ sender: Any) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    @IBAction func postRequest(_ sender: Any) {
        
    }
}
