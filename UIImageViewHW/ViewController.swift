//
//  ViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 6/22/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var macBookCaseLabel: UILabel!
    @IBOutlet weak var appleWatchLabel: UILabel!
    
    @IBOutlet weak var macBookCaseImageView: UIImageView!
    @IBOutlet weak var appleWatchImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizers()
        
    }
    
    func addGestureRecognizers() {
        let tapGestureRecognizerForCase = UITapGestureRecognizer(target: self, action: #selector(caseImageTouch))
        let tapGestureRecognizerForWatch = UITapGestureRecognizer(target: self, action: #selector(watchImageTouch))
        macBookCaseImageView.addGestureRecognizer(tapGestureRecognizerForCase)
        appleWatchImageView.addGestureRecognizer(tapGestureRecognizerForWatch)
        macBookCaseImageView.isUserInteractionEnabled = true
        appleWatchImageView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "caseSegue" {
            guard let destination = segue.destination as? SecondViewController else { return }
            destination.image = macBookCaseImageView.image
            destination.text = macBookCaseLabel.text!
        } else {
            guard let destination = segue.destination as? SecondViewController else { return }
            destination.image = appleWatchImageView.image
            destination.text = appleWatchLabel.text!
            
        }
    }
    
    @objc func caseImageTouch(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "caseSegue", sender: nil)
    }
    
    @objc func watchImageTouch(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "watchSegue", sender: nil)
    }
}
