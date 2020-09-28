//
//  CoursesTableViewController.swift
//  Networking
//
//  Created by Eugene Kiselev on 28.09.2020.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    private var courses = [Course]()
    private var courseName: String?
    private var courseUrl: String?
    private var networkManager = NetworkManager.shared
    private var url = "https://swiftbook.ru//wp-content/uploads/api/api_courses"

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        
        networkManager.fetchData(url: url) { [weak self] courses in
            
            self?.courses = courses
            
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        
        cell.nameLabel.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            
            cell.numberLabel.text = "Number of Lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
            
            cell.label.text = "Number of Tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            
            guard let imageURL = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                
                cell.imageFromModel.image = UIImage(data: imageData)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! DescriptionViewController
        
        webViewController.selectedCourse = courseName
        
        if let url = courseUrl {
            
            webViewController.courseURL = url
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        
        // Сохраняем название курса и ссылку:
        courseUrl = course.link
        courseName = course.name
        
        // осуществляем переход:
        performSegue(withIdentifier: "Description", sender: self)
    }
}

