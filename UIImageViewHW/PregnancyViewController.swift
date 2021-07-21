//
//  PregnancyViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 7/15/21.
//

import UIKit

class PregnancyViewController: UIViewController {
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subViews: [UIView] = [image, label]

    init(withPregnancy: PageVCHelper) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        
        image.image = withPregnancy.image
        label.text = withPregnancy.text
        
        for view in subViews { self.view.addSubview(view) }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400),
            NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400),
            NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150),
            NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: image, attribute: .bottom, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
