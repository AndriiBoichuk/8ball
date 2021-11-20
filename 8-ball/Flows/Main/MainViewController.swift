//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import CoreData
import CLTypingLabel
import SnapKit

class MainViewController: UIViewController {
    
    var mainViewModel: MainViewModel
    
    private let titleLabel = CLTypingLabel()
    private let imageView = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
        loadNavBar()
        
        self.becomeFirstResponder() // To get shake gesture
        mainViewModel.loadItems()
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
            titleLabel.text = L10n.Shake.title.capitalized
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let presentableAnswer = mainViewModel.getPresentableAnswer()
            self.titleLabel.text = presentableAnswer.answer
        }
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        titleLabel.text = L10n.Canceled.Error.title.capitalized
    }
    
    @objc func settingsButtonTapped() {
        let dbManager = mainViewModel.mainModel.getDBManager()
        let model = SettingsModel(dbManager)
        let viewModel = SettingsViewModel(model)
        let settingsVC = SettingsViewController(viewModel)
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
}

private extension MainViewController {
    
    func loadViews() {
        view.backgroundColor = UIColor(asset: Asset.colorBrand)
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
        imageView.image = UIImage(systemName: "iphone.radiowaves.left.and.right")
        imageView.tintColor = .black
    }
    
    func loadNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(settingsButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
}
