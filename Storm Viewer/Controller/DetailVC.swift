//
//  DetailVC.swift
//  Storm Viewer
//
//  Created by olivier geiger on 16/03/2024.
//

import UIKit

class DetailVC: UIViewController {
    
    var selectedImageName: String?
    var fullImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = selectedImageName
        navigationItem.largeTitleDisplayMode = .never
        configure()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func configure() {
        /// Create a new UIImageView object with a defined frame.
        /// The frame specified is view.bounds, which represents the dimensions of the main view of the current view controller.
        fullImageView = UIImageView(frame: view.bounds)
        /// tells the image to maintain its appearance, adjusting to fit completely
        /// within the UIImageView frame, while preserving its proportions
        fullImageView.contentMode = .scaleAspectFit
        
        /// Unwrap the optional selectedImageName, assign its value to imageName
        /// if selectedImageName is not nil
        if let imageName = selectedImageName {
            /// Attempt to create a UIImage with the name contained in imageName
            fullImageView.image = UIImage(named: imageName)
        }
        
        view.addSubview(fullImageView)
    }
    
}
