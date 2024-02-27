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
    
    private let defaults = UserDefaults.standard
    
    var imageLocalPath : String = ""
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Users.plist")
    var usersArray = [UsersDataModel]()
    
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
    
    private let photoView: UIView = {
        let view = UIView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.orange.cgColor
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
    
    let photoPickerView: UIImagePickerController = {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        return piker
    }()
    
    private let nameView: UIView = {
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
    
    let nameTextField: UITextField = {
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
        
    private let dateOfBirthView: UIView = {
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
        label.numberOfLines = 1
        return label
    }()
    
    let dateOfBirthTextField: UITextField = {
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
    
    private let rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let rightImageView: UIImageView = {
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
         self.dateOfBirthView].forEach { stack.addArrangedSubview($0) }
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
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.contentSize = contentSize
        scroll.frame = view.bounds
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .white
        return view
    }()
        
    
    // MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setSubviews()
        setUpConstraints()
        setupTextFields()
        hideKeyboardWhenTappedAround()
        registerForKeyBoardNotifications()
        setupPhotoPicker()
        setupDatePicker()
    }
    
    deinit {
        removeKeyBoardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        safeLoadAndUpdateUserAvatar()
    }
    
    // MARK: - flow funcs
    
    private func setSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        photoView.addSubview(photoImage)
        photoView.addSubview(editPhotoButton)
        
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameTextField)
        
        dateOfBirthView.addSubview(dateOfBirthLabel)
        dateOfBirthView.addSubview(dateOfBirthTextField)
        rightView.addSubview(rightImageView)
        dateOfBirthTextField.addSubview(rightView)
        
        contentView.addSubview(backButton)
        contentView.addSubview(profileLabel)
        contentView.addSubview(photoView)
        contentView.addSubview(settingsStackView)
        contentView.addSubview(saveChangesButton)
    }
    
    private func setUpConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).inset(16)
            make.leading.equalTo(scrollView.snp.leading).inset(24)
            make.trailing.equalTo(scrollView.snp.trailing).inset(24)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(26)
            make.width.equalTo(58)
        }
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(37)
            make.centerX.equalTo(contentView.snp.centerX).inset(5)
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
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(view.frame.width - 48)
        }
        
        nameView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
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
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
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
            make.top.equalTo(settingsStackView.snp.bottom).offset(24)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(48)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
    }
    
}

// MARK: - target actions

extension SettingsViewController {
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func editPhotoPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
            self.present(self.photoPickerView, animated: true)
        }
    }
    
    @objc func saveChangesPressed() {
        print("Save Changes Pressed")
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupPhotoPicker() {
        photoPickerView.delegate = self
        photoPickerView.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        guard let imageFileName = try? StorageManager().saveImage(image) else { return }
        updateUserAvatar(avatarString: imageFileName)
        photoImage.image = image
        print("Update avatar")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension SettingsViewController {
        
    private func updateUserAvatar(avatarString: String) {
        
        guard let currentUserName = defaults.value(forKey: "userName") as? String,
              let currentDateOfBirth = defaults.value(forKey: "dateOfBirth") as? String else { return }

        var usersWithoutCurrent = usersArray.filter { $0.userName != currentUserName }
        let userWithChangedAvatar = UsersDataModel(userName: currentUserName,
                                                   dateOfBirth: currentDateOfBirth,
                                                   userAvatarLocalPath: avatarString)

        usersWithoutCurrent.append(userWithChangedAvatar)

        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(usersWithoutCurrent)
            try data.write(to: dataFilePath!)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    private func safeLoadAndUpdateUserAvatar() {
        guard let imageName = defaults.value(forKey: "avatarLocalPath") as? String else { return }
        if imageName != "" {
            self.photoImage.image = StorageManager().loadImage(from: imageName)
        } else {
            self.photoImage.image = UIImage(named: .avatar)
        }
    }
}


// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    
    func setupTextFields() {
        nameTextField.delegate = self
    }
    
    func registerForKeyBoardNotifications() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    func removeKeyBoardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbWillShow(_ notification: Notification, sender: UITextField) {
        if nameTextField.isEditing {
        } else {
            let userInfo = notification.userInfo
            let keyBoardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            scrollView.contentOffset = CGPoint(x: 0, y: keyBoardFrameSize.height / 2)
        }
    }
    
    @objc private func kbWillHide(sender: UITextField) {
        if nameTextField.isEditing {
        } else {
            scrollView.contentOffset = CGPoint.zero
        }
    }
}

// MARK: - DatePicker

extension SettingsViewController {
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
    }
    
    @objc func doneButtonTapped() {
        
        if let datePickerView = self.dateOfBirthTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            dateOfBirthTextField.text = dateString
            dateOfBirthTextField.resignFirstResponder()
        }
    }
}

// MARK: - hide keyboard

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
