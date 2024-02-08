//
//  StartViewController.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 08.02.2024.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    // MARK: - let/var
    
    private let startView = StartView()

    // MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.delegate = self
        setSubviews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setSubviews() {
        view.addSubview(startView)
    }
    
    private func setupConstraints() {
        startView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - extensions
extension StartViewController: StartViewDelegate {
    
    func pressStartButton(_ view: StartView, sender: UIButton) {
        print("pressStartButton")
    }
    
    func pressSettingsButton(_ view: StartView, sender: UIButton) {
        print("pressSettingsButton")
    }
    
    func pressRecordsButton(_ view: StartView, sender: UIButton) {
        print("pressRecordsButton")
    }
    
}

