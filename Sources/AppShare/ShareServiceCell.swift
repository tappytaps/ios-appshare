//
//  ShareServiceCell.swift
//  AppShare
//
//  Created by Lukas Boura on 02/04/2020.
//

import UIKit

class ShareServiceCell: UITableViewCell {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let separatorView = UIView()
    
    let service: ShareService
    
    init(service: ShareService) {
        self.service = service
        super.init(style: .default, reuseIdentifier: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.spacing = 23
        contentStackView.alignment = .center
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.image = .bundleImage(named: service.imageName)
        
        
        titleLabel.text = service.name
        titleLabel.font = .systemFont(ofSize: 17)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            separatorView.backgroundColor = .systemGray5
        } else {
            separatorView.backgroundColor = .lightGray
        }
        
        contentView.addSubview(contentStackView)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
    }
    
}

extension UIImage {
    
    static func bundleImage(named imageName: String) -> UIImage? {
        guard let resourcesBundleUrl = Bundle(for: ShareServiceCell.self).url(forResource: "AppShareResources", withExtension: "bundle"), let resourcesBundle = Bundle(url: resourcesBundleUrl) else {
            return nil
        }
        return UIImage(named: imageName, in: resourcesBundle, compatibleWith: nil)
    }
    
}
