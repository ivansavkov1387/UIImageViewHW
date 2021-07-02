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
        let tapGestureRecognizerForAnotherCase = UITapGestureRecognizer(target: self, action: #selector(anotherCaseImageTouch))
        
        macBookCaseImageView.addGestureRecognizer(tapGestureRecognizerForCase)
        appleWatchImageView.addGestureRecognizer(tapGestureRecognizerForWatch)
        anotherMacBookCaseImageView.addGestureRecognizer(tapGestureRecognizerForAnotherCase)
        
        macBookCaseImageView.isUserInteractionEnabled = true
        appleWatchImageView.isUserInteractionEnabled = true
        anotherMacBookCaseImageView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "caseSegue" {
            guard let destination = segue.destination as? WebViewController else { return }
            destination.url = "https://www.apple.com/shop/product/MRQM2ZM/A/leather-sleeve-for-13-inch-macbook-pro-saddle-brown?fnode=61b2ea2b9c2517ccf328a478cdd5391e75cafb5dd963cf7e254cd6a5fe1db50efbe9408cbf4221790da583509fda71f6a9d94a09fb331d4bb892be8bae14a6a5040178fef470844ecc7f5b5c37f350c5481a205be3b6736ca94d75efcc21b5b6"
        } else if segue.identifier == "watchSegue" {
            guard let destination = segue.destination as? WebViewController else { return }
            destination.url = "https://www.apple.com/shop/buy-watch/apple-watch?preSelect=false&product=MJ6N3LL/A&step=detail#"
        } else {
            guard let destination = segue.destination as? WebViewController else { return }
            destination.url = "https://www.apple.com/shop/product/HPCZ2ZM/A/incase-compact-sleeve-in-flight-nylon-for-16-macbook-pro-and-15-macbook-pro?fnode=baa7ba65a57372f201c5d3e601f44d6534ad87a7289426b08cc8a103995f8e172d36ce794ef467114b4f51b51676c1836c919f7c85b532a74b8d83be6969244bf18d1ee72e4e317a02f302cfbff3cff152e02910c71bb225ba017ec1a0956d3f3817933b15d23bac4b8b907b2a6159bd"
            
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
