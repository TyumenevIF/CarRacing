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
        button.alpha = 0.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            button.alpha = 1
            self.present(self.settingsView.photoPickerView, animated: true)
        }
    }
    
    func settingsView(_ view: SettingsView, saveChangesPressed button: UIButton) {
        print("saveChangesPressed")
    }
    
    
}

// MARK: - ImagePickerControllerDelegate

extension SettingsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func setupPhotoPicker() {
        settingsView.photoPickerView.delegate = self
        settingsView.photoPickerView.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let choosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageLocalPath = save(image: choosenImage)!
        self.settingsView.photoImage.image = choosenImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController {
    
    private func save(image: UIImage) -> String? {
        let fileName = "FileName"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
}
