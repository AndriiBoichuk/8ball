//
//  ViewController.swift
//  8-ball
//
//  Created by Андрій Бойчук on 24.09.2021.
//

import UIKit
import CoreData
import CLTypingLabel

class MainViewController: UIViewController {

    var mainViewModel: MainViewModel!
    
    @IBOutlet weak var titleLabel: CLTypingLabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        titleLabel.text = L10n.Shake.title.capitalized
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder() // To get shake gesture

        mainViewModel.loadItems()
    }

    func setMainViewModel(_ mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SettingsViewController else { return }
        let dbManager = mainViewModel.mainModel.getDBManager()
        let model = SettingsModel(dbManager)
        let viewModel = SettingsViewModel(model)
        destination.setSettingsViewModel(viewModel)
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
            titleLabel.text = presentableAnswer.answer
        }
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        titleLabel.text = L10n.Canceled.Error.title.capitalized
    }

}
