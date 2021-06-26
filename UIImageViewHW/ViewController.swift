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
    @IBOutlet weak var anotherMacBookCaseLabel: UILabel!
    
    
    @IBOutlet weak var macBookCaseImageView: UIImageView!
    @IBOutlet weak var appleWatchImageView: UIImageView!
    @IBOutlet weak var anotherMacBookCaseImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizers()
        
    }
    
    
    private func addGestureRecognizers() {
        let tapGestureRecognizerForCase = UITapGestureRecognizer(target: self, action: #selector(caseImageTouch))
        let tapGestureRecognizerForWatch = UITapGestureRecognizer(target: self, action: #selector(watchImageTouch))
        let tapGestureRecognizerForAnotherCase = UITapGestureRecognizer(target: self, action: #selector(anotherCaseImageTouch(tapGestureRecognizer:)))
        
        macBookCaseImageView.addGestureRecognizer(tapGestureRecognizerForCase)
        appleWatchImageView.addGestureRecognizer(tapGestureRecognizerForWatch)
        anotherMacBookCaseImageView.addGestureRecognizer(tapGestureRecognizerForAnotherCase)
        
        macBookCaseImageView.isUserInteractionEnabled = true
        appleWatchImageView.isUserInteractionEnabled = true
        anotherMacBookCaseImageView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "caseSegue" {
            guard let destination = segue.destination as? SecondViewController else { return }
            destination.firstImage = macBookCaseImageView.image
            addOtherImages(destination: destination)
            destination.text = macBookCaseLabel.text!
        } else if segue.identifier == "watchSegue" {
            guard let destination = segue.destination as? SecondViewController else { return }
            destination.firstImage = appleWatchImageView.image
            addOtherImages(destination: destination)
            destination.text = appleWatchLabel.text!
        } else {
            guard let destination = segue.destination as? SecondViewController else { return }
            destination.firstImage = anotherMacBookCaseImageView.image
            addOtherImages(destination: destination)
            destination.text = anotherMacBookCaseLabel.text!
        }
    }
    
    private  func addOtherImages(destination: SecondViewController) {
        switch destination.firstImage {
        case macBookCaseImageView.image:
            destination.secondImage = UIImage(named: "2")
        case appleWatchImageView.image:
            destination.secondImage = UIImage(named: "3")
            destination.thirdImage = UIImage(named: "4")
        case anotherMacBookCaseImageView.image:
            destination.secondImage = UIImage(named: "7")
            destination.thirdImage = UIImage(named: "8")
        default:
            break
        }
    }
    
    
    
    @objc private func caseImageTouch(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "caseSegue", sender: nil)
    }
    
    @objc private func watchImageTouch(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "watchSegue", sender: nil)
    }
    
    @objc private func anotherCaseImageTouch(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "anotherCase", sender: nil)
    }
}
