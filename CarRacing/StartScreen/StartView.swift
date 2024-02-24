//
//  StartView.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 08.02.2024.
//

import UIKit
import SnapKit

protocol StartViewDelegate: AnyObject {
    func pressStartButton(_ view: StartView, sender: UIButton)
    func pressSettingsButton(_ view: StartView, sender: UIButton)
    func pressRecordsButton(_ view: StartView, sender: UIButton)
}

final class StartView: UIView {
    
    // MARK: - let/var
    
    weak var delegate: StartViewDelegate?

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .startScreen
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
            
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .system20
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .orange
        button.layer.cornerRadius = .buttonCornerRadius
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.font = .system20
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .orange
        button.layer.cornerRadius = .buttonCornerRadius
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var recordsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Records", for: .normal)
        button.titleLabel?.font = .system20
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .orange
        button.layer.cornerRadius = .buttonCornerRadius
        button.addTarget(self, action: #selector(recordsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - lifecycle funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - flow funcs
    
    private func setSubviews() {
        addSubview(backgroundImageView)
        addSubview(startButton)
        addSubview(settingsButton)
        addSubview(recordsButton)
    }
    
    private func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(62)
        }
        
        settingsButton.snp.makeConstraints { (make) in
            make.top.equalTo(startButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(62)
        }
        
        recordsButton.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(62)
        }
    }
}

// MARK: - extensions

private extension StartView {
    
    @objc func startButtonPressed(_ sender: UIButton) {
        delegate?.pressStartButton(self, sender: sender)
    }
    
    @objc func settingsButtonPressed(_ sender: UIButton) {
        delegate?.pressSettingsButton(self, sender: sender)
    }
    
    @objc func recordsButtonPressed(_ sender: UIButton) {
        delegate?.pressRecordsButton(self, sender: sender)
    }
}

