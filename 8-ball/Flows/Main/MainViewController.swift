//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import CoreData
import SnapKit

class MainViewController: UIViewController {
    
    private let mainViewModel: MainViewModel
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let counterLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
        loadNavBar()
        
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
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Enable detection of shake motion
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            titleLabel.text = L10n.Shaking.title.capitalized
            counterLabel.text = L10n.Counter.title + mainViewModel.getQuantity()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            var resultAnswer = String()
            mainViewModel.getPresentableAnswer { presentableAnswer in
                resultAnswer = presentableAnswer.answer
                DispatchQueue.main.async {
                    self.titleLabel.text = resultAnswer
                }
                self.mainViewModel.addAnswer(resultAnswer)
            }
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        titleLabel.text = L10n.Canceled.Error.title.capitalized
    }
    
    @objc func settingsButtonTapped() {
        navigationController?.pushViewController(getSettingsVC(), animated: true)
    }
    
    private func getSettingsVC() -> SettingsViewController {
        let dbManager = mainViewModel.mainModel.getDBManager()
        let model = SettingsModel(dbManager)
        let viewModel = SettingsViewModel(model)
        let settingsVC = SettingsViewController(viewModel)
        return settingsVC
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
