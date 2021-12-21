//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let mainViewModel: MainViewModel
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let counterLabel = UILabel()
    
    private var isThreeSecPassed = false
    private var isResponseReceived = false
    
    private let disposeBag = DisposeBag()
    
    private var textTitle = BehaviorRelay(value: "")
    private var textCounter = BehaviorRelay(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
        loadNavBar()
        
        setupBindings()
        
        self.becomeFirstResponder() // To get shake gesture
        mainViewModel.loadItems()
        
        mainViewModel.setConnectionStatus()
    }
    
    init(_ mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        textTitle.asObservable()
            .filter {!$0.isEmpty}
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        textCounter.asObservable()
            .filter {!$0.isEmpty}
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Enable detection of shake motion
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            titleLabel.text = L10n.Shaking.title.capitalized
            titleLabel.text = L10n.Counter.title + mainViewModel.getQuantity()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            DispatchQueue.main.async {
                self.setTimer()
                self.animateImage()
                self.isThreeSecPassed = false
                self.isResponseReceived = false
            }
            var resultAnswer = String()
            mainViewModel.getPresentableAnswer()
                .observe(on: MainScheduler.asyncInstance)
                .subscribe { [weak self] presentableAnswer in
                    resultAnswer = presentableAnswer.answer
                    self?.setAnswer(answer: resultAnswer)
                    self?.isResponseReceived = true
                    
                    self?.mainViewModel.addAnswer(resultAnswer)
                } onError: { error in
                    print(error)
                }.disposed(by: self.disposeBag)
        }
        
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        textTitle.accept(L10n.Canceled.Error.title.capitalized)
    }
    
    @objc func settingsButtonTapped() {
        print("OK")
        mainViewModel.presentSettings()
    }
    
}

private extension MainViewController {
    
    func loadViews() {
        view.backgroundColor = UIColor(asset: Asset.colorBrand)
        view.addSubview(counterLabel)
        counterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        counterLabel.text = L10n.Counter.title + mainViewModel.getQuantity()
        counterLabel.tintColor = .black
        counterLabel.font = UIFont(name: Constants.fontName, size: 18)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(self.view.safeAreaLayoutGuide.snp.center)
            make.height.equalTo(64)
            make.width.equalTo(342)
        }
        titleLabel.text = L10n.Shake.title.capitalized
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: Constants.fontName, size: 26)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(18)
            make.width.equalTo(179)
            make.height.equalTo(120)
        }
        imageView.image = UIImage(systemName: L10n.Image.shakeIphone)
        imageView.tintColor = .black
    }
    
    func loadNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: L10n.Image.settings),
            style: .done,
            target: self,
            action: #selector(settingsButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
}

private extension MainViewController {
    func animateImage() {
        let transform = imageView.transform
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.imageView.transform = transform
            }) { _ in
                if !self.isResponseReceived || !self.isThreeSecPassed {
                    self.animateImage()
                }
            }
        }
    }
    
    func setTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isThreeSecPassed = true
        }
    }
    
    func setAnswer(answer: String) {
        UIView.transition(with: titleLabel, duration: 0.2, options: .transitionFlipFromLeft, animations: {
            self.textTitle.accept(answer)
        }, completion: nil)
    }
    
}
