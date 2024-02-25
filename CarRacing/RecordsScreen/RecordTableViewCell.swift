//
//  RecordTableViewCell.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 25.02.2024.
//

import UIKit
import SnapKit

final class RecordTableViewCell: UITableViewCell {
    
    // MARK: - let/var
    
    static var identifier: String { "\(Self.self)"}
    
    var record: UsersDataModel? {
        didSet {
            guard let recordItem = record else { return }
            if let username = recordItem.userName {
                profileImageView.image = UIImage(named: username)
                nameLabel.text = username
            }
            if let dateOfBirth = recordItem.dateOfBirth {
                dateOfBirthLabel.text = "\(dateOfBirth)"
            }
            
            if let points = recordItem.points {
                pointsLabel.text = "\(points) points"
            }
            
            if let gameDate = recordItem.gameDate {
                gameDateLabel.text = "\(gameDate)"
            }
        }
    }
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .system16
        label.textColor = .white
        label.backgroundColor = .orange
        label.layer.cornerRadius = .labelCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.font = .system16
        label.textColor = .white
        label.backgroundColor = .orange
        label.layer.cornerRadius = .labelCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .system16
        label.textColor = .black
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.orange.cgColor
        label.layer.cornerRadius = .labelCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let gameDateLabel: UILabel = {
        let label = UILabel()
        label.font = .system16
        label.textColor = .black
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.orange.cgColor
        label.layer.cornerRadius = .labelCornerRadius
        label.clipsToBounds = true
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - lifecycle funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - flow funcs
    
    private func setSubviews() {
        contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(dateOfBirthLabel)
        containerView.addSubview(pointsLabel)
        containerView.addSubview(gameDateLabel)
        contentView.addSubview(containerView)
    }
    
    private func setUpConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(profileImageView.snp.trailing).offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
            make.height.equalTo(20)
        }
        
        dateOfBirthLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
        
        gameDateLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
    }
}
