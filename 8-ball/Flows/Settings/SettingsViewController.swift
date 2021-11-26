//
//  SettingsViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 28.09.2021.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    private let settingsViewModel: SettingsViewModel
    
    private let answerTextField = UITextField()
    private let saveButtonView = UIView()
    private let saveButton = UIButton()
    private let answersButtom = UIButton()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
        loadNavBar()
        
        settingsViewModel.loadItems()
    }
    
    init(_ viewModel: SettingsViewModel) {
        self.settingsViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        turnOffButtonPressed()
    }
    
    @objc func saveTouched() {
        if let answer = answerTextField.text {
            settingsViewModel.addAnswer(answer)
            saveButton.isEnabled = false
        }
        answerTextField.text = ""
    }
    
//    @objc func seeAnswersTouched() {
//
//        navigationController?.pushViewController(getAnswersVC(), animated: true)
//    }
//
//    private func getAnswersVC() -> AnswersTableViewController {
//        let dbManager = settingsViewModel.settingsModel.getDBManager()
//        let model = AnswersModel(dbManager)
//        let viewModel = AnswersViewModel(model)
//        let settingsVC = AnswersTableViewController(viewModel)
//        return settingsVC
//    }
    
    func turnOffButtonPressed() {
        saveButton.isEnabled = answerTextField.text == "" ? false : true
    }
    
}

// MARK: - TextField Delegate

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let answer = answerTextField.text {
            settingsViewModel.addAnswer(answer)
        }
        answerTextField.text = ""
        turnOffButtonPressed()
        return true
    }
    
}

private extension SettingsViewController {
    
    func loadViews() {
        view.backgroundColor = UIColor(asset: Asset.colorBrand)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.width.equalTo(120)
            make.height.equalTo(90)
        }
        imageView.image = UIImage(systemName: "wifi.slash")
        imageView.tintColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(26)
            make.height.equalTo(40)
        }
        titleLabel.text = "Hardcoded answers"
        titleLabel.font = UIFont(name: Constants.fontName, size: 24)
        
        view.addSubview(answerTextField)
        answerTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        answerTextField.delegate = self
        answerTextField.layer.cornerRadius = 10
        answerTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        answerTextField.placeholder = "Type something..."
        answerTextField.backgroundColor = .white
        
        saveButtonView.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.center.equalTo(saveButtonView.snp.center)
            make.width.equalTo(77)
            make.height.equalTo(55)
        }
        saveButton.addTarget(self, action: #selector(saveTouched), for: .touchUpInside)
        saveButton.setTitle("Add", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.titleLabel?.font = UIFont(name: Constants.fontName, size: 18)
        saveButton.isEnabled = false
        
        view.addSubview(saveButtonView)
        saveButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(12)
            make.width.equalTo(117)
            make.height.equalTo(75)
        }
        saveButtonView.layer.cornerRadius = 10
        saveButtonView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func loadNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: Constants.fontName, size: 22)!
        ]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.title = "Settings"
    }
    
}
