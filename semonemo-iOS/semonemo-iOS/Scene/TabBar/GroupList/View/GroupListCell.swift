//
//  GroupListCell.swift
//  semonemo-iOS
//
//  Created by Ellen on 2022/07/22.
//

import UIKit
import SnapKit

class GroupListCell: UICollectionViewCell {
    static let id: String = "\(GroupListCell.self)"
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "circle"))
        image.tintColor = .green
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .black
        label.text = "hi"
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        // snp 적용하기
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func setUpLabel(group: GroupInfo) {
        titleLabel.text = "\(group.place.address)"
        locationLabel.text = "\(group.place.address)"
        dateLabel.text = group.startDate
    }
}
