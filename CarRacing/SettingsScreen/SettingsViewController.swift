//
//  SettingsViewController.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 10.02.2024.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    // MARK: - let/var
    
    private let settingsView = SettingsView()
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var imageLocalPath : String = ""
    
    // MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
        setSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setSubviews() {
        view.backgroundColor = .white
        view.addSubview(settingsView)
    }
    
    private func setupConstraints() {
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - ProfileViewDelegate
extension SettingsViewController: SettingsViewDelegate {
    
    func settingsView(_ view: SettingsView, backButtonPressed button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func settingsView(_ view: SettingsView, editPhotoPressed button: UIButton) {
        print("editPhotoPressed")
    }
    
    func settingsView(_ view: SettingsView, saveChangesPressed button: UIButton) {
        print("saveChangesPressed")
    }
    
    
}
