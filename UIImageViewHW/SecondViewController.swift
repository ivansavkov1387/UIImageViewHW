//
//  SecondViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 6/22/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    var image: UIImage!
    var text = ""
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewOutlet.image = image
        labelOutlet.text = text
    }

}
