//
//  SettingsView.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 23.02.2024.
//

import Foundation
import SnapKit

protocol SettingsViewDelegate: AnyObject {
    func settingsView(_ view: SettingsView, backButtonPressed button: UIButton)
    func settingsView(_ view: SettingsView, editPhotoPressed button: UIButton)
    func settingsView(_ view: SettingsView, saveChangesPressed button: UIButton)
}

final class SettingsView: UIView {
    
    // MARK: - let/var
    
    weak var delegate: SettingsViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "backImage"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .system20
        label.textColor = .black
        return label
    }()
    
    private lazy var photoView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var editPhotoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "editPhotoImage"), for: .normal)
        button.addTarget(self, action: #selector(editPhotoPressed), for: .touchUpInside)
        return button
    }()
    
    private let photoPickerView: UIImagePickerController = {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        return piker
    }()
    
    private lazy var nameView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .system20
        label.textColor = .gray
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .system16
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.placeholder = "Enter name"
        textField.minimumFontSize = 12
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .continue
        textField.clearButtonMode = .whileEditing
        return textField
    }()
        
    private lazy var dateOfBirthView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of birth"
        label.font = .system20
        label.textColor = .gray
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.placeholder = "Choose your date of birth"
        textField.minimumFontSize = 12
        textField.layer.borderColor = UIColor.orange.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendarIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var settingsStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 24
        [self.nameView,
         self.dateOfBirthView,
         self.saveChangesButton].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.titleLabel?.font = .system20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = .buttonCornerRadius
        button.addTarget(self, action: #selector(saveChangesPressed), for: .touchUpInside)
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
        photoView.addSubview(photoImage)
        photoView.addSubview(editPhotoButton)
        
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameTextField)
        
        dateOfBirthView.addSubview(dateOfBirthLabel)
        dateOfBirthView.addSubview(dateOfBirthTextField)
        rightView.addSubview(rightImageView)
        dateOfBirthTextField.addSubview(rightView)
        
        addSubview(backButton)
        addSubview(profileLabel)
        addSubview(photoView)
        addSubview(settingsStackView)
    }
    
    private func setUpConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(16)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
            make.width.equalTo(58)
        }
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.centerX.equalToSuperview().inset(5)
            make.width.equalTo(105)
            make.height.equalTo(100)
        }
        
        photoImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(68)
            make.leading.equalToSuperview().offset(73)
            make.width.height.equalTo(32)
        }
        
        settingsStackView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        nameView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(82)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        dateOfBirthView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(82)
        }
        
        dateOfBirthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(22)
        }
        
        dateOfBirthTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { make in
            make.trailing.equalTo(dateOfBirthTextField.snp.trailing).inset(12)
            make.centerY.equalTo(dateOfBirthTextField.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
        
}

// MARK: - extensions
    
private extension SettingsView {
    
    @objc func backButtonPressed(_ button: UIButton) {
        delegate?.settingsView(self, backButtonPressed: button)
    }
    
    @objc func editPhotoPressed(_ button: UIButton) {
        delegate?.settingsView(self, editPhotoPressed: button)
    }
    
    @objc func saveChangesPressed(_ button: UIButton) {
        delegate?.settingsView(self, saveChangesPressed: button)
    }
}
