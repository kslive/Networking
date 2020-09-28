//
//  NetworkManager.swift
//  Networking
//
//  Created by Eugene Kiselev on 28.09.2020.
//

import UIKit

class NetworkManager {
    
    static var shared = NetworkManager()
    
    func getRequest(url: String) {
        
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard let _ = response, let data = data else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func postRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let userData = ["Course":"Networking", "Lesson":"Get and Post Request"]
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func downloadImage(url: String, completion: @escaping (_ image: UIImage)->()) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    
                    completion(image)
                }
            }
        }.resume()
    }
    
    func fetchData(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        let jsonUrlString = url
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                
                completion(courses)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    private init() {}
}
