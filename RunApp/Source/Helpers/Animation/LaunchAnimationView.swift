//
//  LaunchAnimationView.swift
//  RunChecker
//
//  Created by Мария Хатунцева on 22.02.2023.
//

import UIKit

final class LaunchAnimationView: UIView {
    
    private lazy var backgroundLightLayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0.0
        layer.backgroundColor = BackgroundLayerType.light.backgroundColor.cgColor
        return layer
    }()
    private lazy var backgroundDarkLayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0.0
        layer.backgroundColor = BackgroundLayerType.dark.backgroundColor.cgColor
        return layer
    }()
    private lazy var backgroundWhiteLayer: CALayer = {
        let layer = CALayer()
        layer.opacity = 0.0
        layer.backgroundColor = BackgroundLayerType.white.backgroundColor.cgColor
        return layer
    }()
    private lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "hare"))
        imageView.alpha = 0.0
        return imageView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Помощник в беге:\nследи за маршрутом \nи всеми показателями."
        label.font = UIFont.systemFont(ofSize: 19.0)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 4
        label.alpha = 0.0
        return label
    }()
    
    enum BackgroundLayerType {
        
        case light, dark, white
        
        var backgroundColor: UIColor {
            switch self {
            case .white:
                return .white
            case .light:
                return Colors.energyGreen
            case .dark:
                return Colors.primaryTeal

            }
        }
    }
    
    var onCompletion: (() -> Void)?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
       
        initUI()
        initFrames()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        layer.backgroundColor = BackgroundLayerType.dark.backgroundColor.cgColor
        
        addSubview(logo)
        addSubview(label)
    }
    
    private func initFrames() {
        logo.center = CGPoint(x: center.x, y: center.y + (bounds.height / 2) * 0.4)
        logo.transform = CGAffineTransform.identity.scaledBy(x: 15.25, y: 15.25)
        
        label.sizeToFit()
        label.center = CGPoint(x: center.x, y: center.y + (bounds.height / 2) * 0.8)
        
        [backgroundLightLayer, backgroundDarkLayer, backgroundWhiteLayer].forEach {
            $0.frame = .init(x: 0, y: 0, width: bounds.width, height: bounds.width)
            $0.position = center
            $0.cornerRadius = backgroundLightLayer.bounds.width / 2
        }
    }
    
    func startAnimation() {
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)

        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timingFunction)

        UIView.animate(withDuration: 1) {
            self.logo.alpha = 1.0
            self.logo.transform = .identity
            self.logo.center = CGPoint(x: self.center.x, y: self.center.y - self.logo.bounds.height / 2 - 12)

            self.label.alpha = 1.0
            self.label.center = CGPoint(x: self.center.x, y: self.center.y + self.logo.bounds.height / 2 + 12)
        }

        CATransaction.commit()
        
        animateBackgroundLayer(type: .light)
        animateBackgroundLayer(type: .dark)
        animateBackgroundLayer(type: .white)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 + 1 + 1 + 0.6) {
            self.onCompletion?()
        }
    }
    
    private func animateBackgroundLayer(type: BackgroundLayerType) {
        let currentLayer: CALayer
        let beginTime: CFTimeInterval
        let timeDelay = 1.0
        switch type {
        case .light:
            currentLayer = self.backgroundLightLayer
            self.layer.insertSublayer(currentLayer, at: 0)
            beginTime = CACurrentMediaTime() + timeDelay
        case .dark:
            currentLayer = self.backgroundDarkLayer
            self.layer.insertSublayer(currentLayer, above: backgroundLightLayer)
            beginTime = CACurrentMediaTime() + timeDelay * 2
        case .white:
            currentLayer = self.backgroundWhiteLayer
            self.layer.insertSublayer(currentLayer, above: backgroundDarkLayer)
            beginTime = CACurrentMediaTime() + timeDelay * 3
        }
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.7
        scaleAnimation.toValue = 3
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.1
        opacityAnimation.toValue = 1.0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.beginTime = beginTime
        groupAnimation.duration = type == .white ? 0.6 : 1
        groupAnimation.repeatCount = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false

        currentLayer.add(groupAnimation, forKey: "groupAnimation")
        
        if type == .white {
            animateLabelsOut(beginTime)
        }
    }
    
    private func animateLabelsOut(_ beginTime: CFTimeInterval) {
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        
        let positionAnimationLabel = CABasicAnimation(keyPath: "position")
        positionAnimationLabel.toValue = CGPoint(
            x: self.center.x,
            y: self.center.y + (self.bounds.height / 3) * 0.8
        )

        let groupAnimationLabel = CAAnimationGroup()
        groupAnimationLabel.animations = [opacityAnimation, positionAnimationLabel]
        groupAnimationLabel.beginTime = beginTime
        groupAnimationLabel.duration = 0.6
        groupAnimationLabel.repeatCount = 1
        groupAnimationLabel.timingFunction = timingFunction
        groupAnimationLabel.fillMode = .forwards
        groupAnimationLabel.isRemovedOnCompletion = false
        
        let positionAnimationLogo = CABasicAnimation(keyPath: "position")
        positionAnimationLogo.toValue = CGPoint(
            x: self.center.x,
            y: self.center.y - (self.bounds.height / 2) * 0.8
        )
        
        let scaleAnimationLogo = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimationLogo.toValue = 0.7
        
        let opacityAnimationLogo = CABasicAnimation(keyPath: "opacity")
        opacityAnimationLogo.fromValue = 1.0
        opacityAnimationLogo.toValue = 0.0
        
        let groupAnimationLogo = CAAnimationGroup()
        groupAnimationLogo.animations = [
            opacityAnimationLogo,
            positionAnimationLogo,
            scaleAnimationLogo
        ]
        groupAnimationLogo.beginTime = beginTime
        groupAnimationLogo.duration = 6.6
        groupAnimationLogo.repeatCount = 1
        groupAnimationLogo.timingFunction = timingFunction
        groupAnimationLogo.fillMode = .forwards
        groupAnimationLogo.isRemovedOnCompletion = false
        
        label.layer.add(groupAnimationLabel, forKey: "groupAnimationLabel")
        logo.layer.add(groupAnimationLogo, forKey: "groupAnimationLogo")
    }
}

