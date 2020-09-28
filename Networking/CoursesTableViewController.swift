//
//  CoursesTableViewController.swift
//  Networking
//
//  Created by Eugene Kiselev on 28.09.2020.
//

import UIKit

class CoursesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let courses = try JSONDecoder().decode([Course].self, from: data)
                
                print(courses)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
}

extension CoursesTableViewController {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
