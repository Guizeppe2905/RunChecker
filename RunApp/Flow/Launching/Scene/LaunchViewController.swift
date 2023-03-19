//
//  LaunchViewController.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//

import UIKit

class LaunchViewController: UIViewController, LaunchAssemblable {
    
    private var presenter: LaunchPresenterInputFromView?
    var onCompletion: CompletionBlock?
    
    func setupDependencies(presenter: LaunchPresenterInputFromView) {
        self.presenter = presenter
    }

    private let launchAnimationView = LaunchAnimationView()

    func startAnimation() {
        launchAnimationView.startAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(launchAnimationView)
        startAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.launchAnimationView.onCompletion = self.onCompletion
        }
    }
}
