//
//  PageViewController.swift
//  UIImageViewHW
//
//  Created by Иван on 7/15/21.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    
    //MARK: - Private properties
    
    var imagesAndText = [PageVCHelper]()
    
    private let pageControl = UIPageControl()
    private let skipButton = UIButton()
    private let nextButton = UIButton()
    private let getStartedButton = UIButton()
    private var initialPage = 0
    
    let firstImage = UIImage(named: "pregnancy1")
    let secondImage = UIImage(named: "pregnancy2")
    let thirdImage = UIImage(named: "pregnancy3")
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstItem = PageVCHelper(image: firstImage!, text: "Track Your Cycle")
        let secondItem = PageVCHelper(image: secondImage!, text: "Plan Your Pregnancy")
        let thirdItem = PageVCHelper(image: thirdImage!, text: "Daily Health Insight")
        
        imagesAndText.append(firstItem)
        imagesAndText.append(secondItem)
        imagesAndText.append(thirdItem)
        
        UserDefaults.standard.set(true, forKey: "firstTimeOpened")
        
        setupPageViewController()
        layout()
        style()
        showGetStartedButton(show: false)
    }
    
    //MARK: - Create the VC
    lazy var arrayOfViewControllers: [UIViewController] = {
        var arrayOfVС = [UIViewController]()
        for item in imagesAndText {
            arrayOfVС.append(PregnancyViewController(withPregnancy: item))
        }
        return arrayOfVС
    }()
    
    //MARK: - Setup UIPageViewController
    
    private func setupPageViewController() {
        self.delegate = self
        self.dataSource = self
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        setViewControllers([arrayOfViewControllers[initialPage]], direction: .forward, animated: true, completion: nil)
        view.backgroundColor = .white
    }
    
    //MARK: - Layout
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            NSLayoutConstraint(item: getStartedButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: getStartedButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100),
            NSLayoutConstraint(item: getStartedButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 500),
            NSLayoutConstraint(item: getStartedButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            
            skipButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
        ])
        
        // for animations
        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        
        pageControlBottomAnchor?.isActive = true
        skipButtonTopAnchor?.isActive = true
        nextButtonTopAnchor?.isActive = true
    }
    
    //MARK: - Methods
    private func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = arrayOfViewControllers.count
        pageControl.currentPage = initialPage
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.systemBlue, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitleColor(.systemBlue, for: .normal)
        getStartedButton.setTitle("Get started!", for: .normal)
        getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([arrayOfViewControllers[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }
    
    @objc func skipTapped(_ sender: UIButton) {
        let lastPage = arrayOfViewControllers.count - 1
        pageControl.currentPage = lastPage
        goToSpecificPage(index: lastPage, ofViewControllers: arrayOfViewControllers)
        animateControlsIfNeeded()
        performSegue(withIdentifier: "getStarted", sender: nil)
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }
    
    @objc func getStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "getStarted", sender: nil)
    }
    
    private func showGetStartedButton(show: Bool) {
        if show {
            getStartedButton.isEnabled = true
            getStartedButton.isHidden = false
            pageControl.isHidden = true
            pageControl.isEnabled = false
        } else {
            getStartedButton.isEnabled = false
            getStartedButton.isHidden = true
            pageControl.isHidden = false
            pageControl.isEnabled = true
        }
    }
}

extension PageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([arrayOfViewControllers[index]], direction: .forward, animated: true, completion: nil)
    }
}

//MARK: - Extension UIPageViewController

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = arrayOfViewControllers.firstIndex(of: viewController as! PregnancyViewController) else { return nil }
        
        if currentIndex == 0 {
            return arrayOfViewControllers.last               // wrap to last
        } else {
            return arrayOfViewControllers[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = arrayOfViewControllers.firstIndex(of: viewController as! PregnancyViewController) else { return nil }
        
        if currentIndex < arrayOfViewControllers.count - 1 {
            return arrayOfViewControllers[currentIndex + 1]  // go next
        } else {
            return arrayOfViewControllers.first              // wrap to first
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return initialPage
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayOfViewControllers.count
    }
}
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = arrayOfViewControllers.firstIndex(of: viewControllers[0] as! PregnancyViewController) else { return }
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == arrayOfViewControllers.count - 1
        
        if lastPage {
            hideControls()
            showGetStartedButton(show: lastPage)
        } else {
            showControls()
            showGetStartedButton(show: lastPage)
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideControls() {
        pageControl.isEnabled = false
        pageControlBottomAnchor?.constant = -80
        skipButtonTopAnchor?.constant = -80
        nextButtonTopAnchor?.constant = -80
    }
    
    private func showControls() {
        pageControlBottomAnchor?.constant = 16
        skipButtonTopAnchor?.constant = 16
        nextButtonTopAnchor?.constant = 16
    }
    
}
