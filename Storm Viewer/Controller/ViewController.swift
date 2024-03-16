//
//  ViewController.swift
//  Storm Viewer
//
//  Created by olivier geiger on 16/03/2024.
//

import UIKit

class ViewController: UIViewController{
    /// create a Array of String asign to the pictures variables
    /// it's not a constant and it will be empty
    var pictures = [String]()
    /// create a tableView variable of type UITableView
    var tableView: UITableView!
    
    var reuseID: String = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        /// declares a constant called fm and assigns in the value returned by FileManager.default
        /// This is a data type that lets us work with the filesystem
        let fm = FileManager.default
        /// declares a constant called path that is set to the resource path of our app's bundle
        let path = Bundle.main.resourcePath!
        /// declares a  constant called items that is set to the contents of the directory at a path.
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        /// starts a loop that will execute once for every item we found in the app bundle
        for item in items {
            if item.hasPrefix("nssl") {
                /// add all item to pictures
                pictures.append(item)
            }
        }
        
        /// Initialize UITableView
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        view.addSubview(tableView)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// return how many pictures we have in the pictures Array
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// we are retrieving a reusable cell from the UITableView
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        /// displays text for each index
        cell.textLabel?.text = pictures[indexPath.row]
        /// add a standard navigation arrow to the cell. This arrow indicates to users that they can
        /// press this cell to access more information or another screen.
        cell.accessoryType = .disclosureIndicator
        
        /// to change the backgound of the cell
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        cell.selectedBackgroundView = selectedView
        
        /// return the cell
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Implement what happens when a row is selected, if needed
        // For example, you can display the selected image
        // let selectedPicture = pictures[indexPath.row]
        // Now, do something with selectedPicture
    }
}
