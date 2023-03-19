//
//  SliderView.swift
//  RunApp
//
//  Created by Мария Хатунцева on 12.03.2023.
//
import UIKit

class SliderView: UIView {
    
    lazy var capsuleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var stopSliderKnob: UIImageView = {
       let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.addSubview(arrowSlider)
        return view
    }()
    
    lazy var buttonTitle: UILabel = {
       let label = UILabel()
        label.text = "Слайдер - Остановить"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var arrowSlider: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.and.right.circle"), for: .normal)
         return button
    }()
    
   var sliderStop: UIImageView = {
       let view = UIImageView()
       view.image = UIImage(systemName: "stop.circle.fill")
       view.tintColor = Colors.darkGreen
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(capsuleView)
        [
           buttonTitle, stopSliderKnob, sliderStop
        ].forEach {
            capsuleView.addSubview($0)
        }
        initConstraints()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isUserInteractionEnabled: Bool {
        get {
            super.isUserInteractionEnabled
        }
        set(value) {
            super.isUserInteractionEnabled = value

            capsuleView.backgroundColor = isUserInteractionEnabled ? Colors.energyGreen : Colors.darkGreen
            arrowSlider.tintColor = isUserInteractionEnabled ? Colors.teal : Colors.primaryTeal
            buttonTitle.textColor = isUserInteractionEnabled ? Colors.teal : Colors.primaryTeal
            stopSliderKnob.isUserInteractionEnabled = isUserInteractionEnabled ? true : false
        }
    }
    
    func initConstraints() {
        capsuleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(66)
            make.bottom.equalToSuperview()
        }
        buttonTitle.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(capsuleView)
            make.width.equalTo(230)
            make.height.equalTo(24)
        }
        stopSliderKnob.snp.makeConstraints { make in
            make.leading.equalTo(capsuleView).offset(8)
            make.centerY.equalTo(capsuleView)
            make.width.height.equalTo(50)
        }
        arrowSlider.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(stopSliderKnob)
            make.width.height.equalTo(20)
        }
        sliderStop.snp.makeConstraints { make in
            make.trailing.equalTo(capsuleView).offset(-10)
            make.centerY.equalTo(capsuleView)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
    }
}

