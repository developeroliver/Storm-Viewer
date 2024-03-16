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
        
        /// title of the screen
        title = "Storm Viewer"
        /// change the large titles by false
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        // Initialize UITableView
        /// this creates a new instance of UITableView with a frame corresponding to the size of the view.
        tableView = UITableView(frame: view.bounds, style: .plain)
        /// It defines the current controller as the table's data source. 
        /// This means that the controller will provide the data to be displayed in the table.
        tableView.dataSource = self
        /// It defines the current controller as the table's delegate.
        /// The delegate is responsible for handling table-specific events and behaviors, such as cell selection.
        tableView.delegate = self
        /// It registers a cell type (UITableViewCell) for reuse with a specific identifier (reuseID).
        /// This is useful so that the table can create and reuse cells efficiently when scrolling.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        
        /// adds the previously created UITableView to a superior view, probably the main view of your view controller.
        view.addSubview(tableView)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// returns the number of rows (or elements) in the specified section of the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// return how many pictures we have in the pictures Array
        return pictures.count
    }
    
    
    /// provides a cell for a specified location (or row) in the table.
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
    
    
    /// is called when the user selects a cell in the table.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// This line creates a new instance of your DetailVC class,
        /// which is your detailed view controller for displaying full-screen images.
        let fullImageVC = DetailVC()
        /// This property is used to load and display the appropriate image in your detailed view controller.
        fullImageVC.selectedImageName = pictures[indexPath.row]
        /// DetailVC becomes the active view controller, and is displayed on screen.
        navigationController?.pushViewController(fullImageVC, animated: true)
    }
}
