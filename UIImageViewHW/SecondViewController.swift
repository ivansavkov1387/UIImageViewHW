//
//  SecondViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 6/22/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    private var firstImage: UIImage!
    private var secondImage: UIImage!
    private var thirdImage: UIImage!
    
    private var text = ""
    
    @IBOutlet weak var firstImageViewOutlet: UIImageView!
    @IBOutlet weak var secondImageOutlet: UIImageView!
    @IBOutlet weak var thirdImageOutlet: UIImageView!
    
    @IBOutlet weak var labelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        
        firstImageViewOutlet.image = firstImage
        secondImageOutlet.image = secondImage
        
        if let image = thirdImage {
            thirdImageOutlet.image = image
        }
        labelOutlet.text = text
    }
    
    
}
