//
//  ViewController.swift
//  Project-Sunday-002_Alternate-App-Icon
//
//  Created by Virata Yindeeyoungyeon on 4/22/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var weatherSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        var selectedIndex = 0
        if let alternateIconName = UIApplication.shared.alternateIconName {
            weatherImageView.image = UIImage.init(named: alternateIconName)
            for index in 0..<weatherSegmentedControl.numberOfSegments {
                let segmentedTitle = weatherSegmentedControl.titleForSegment(at:index)
                if alternateIconName == segmentedTitle?.lowercased() {
                    selectedIndex = index
                    break
                }
            }
        }
        
        weatherSegmentedControl.selectedSegmentIndex = selectedIndex
    }
    
    @IBAction func weatherSegmentedControlTapped(_ sender: UISegmentedControl) {
        
        guard UIApplication.shared.supportsAlternateIcons else {
            let deviceVersionAlert = UIAlertController(title: "Error", message: "Please update your device to iOS 10.3+", preferredStyle:.alert)
            deviceVersionAlert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            self.show(deviceVersionAlert, sender: nil)
            return
        }
        
        if let imageName = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            let imageNameLowerCase = imageName.lowercased()
            weatherImageView.image = UIImage.init(named: imageNameLowerCase)
            
            UIApplication.shared.setAlternateIconName(imageNameLowerCase, completionHandler: { (error) in
                if let e = error {
                    print(e.localizedDescription)
                }
            })
        }
    }
}

