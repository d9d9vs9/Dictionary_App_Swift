//
//  SettingsCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 31.05.2021.
//

import UIKit

final class SettingsCell: UICollectionViewCell,
                          ReuseIdentifierProtocol {
    
    fileprivate static let titleLabelConfiguration = StandardLabelConfigurationModel.init(font: AppStyling.Font.systemFont.font(),
                                                                                          textColor: AppStyling.labelTextColor(),
                                                                                          textAlignment: .left,
                                                                                          numberOfLines: .zero)
    
    static let height: CGFloat = 40
    
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
}

// MARK: - FillWithModelProtocol
extension SettingsCell: FillWithModelProtocol {
    
    typealias Model = SettingsRowModel?
    
    func fillWithModel(_ model: SettingsRowModel?) {
        self.titleLabel.text = model?.titleText
    }
    
}

// MARK: - Add Views
fileprivate extension SettingsCell {
    
    func addViews() {
        addTitleLabel()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
}

// MARK: - Add Constraints
fileprivate extension SettingsCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
    }
    
    func addTitleLabelConstraints() {
        NSLayoutConstraint.addEqualTopConstraintAndActivate(item: titleLabel,
                                                            toItem: self,
                                                            constant: .zero)
        NSLayoutConstraint.addEqualLeftConstraintAndActivate(item: titleLabel,
                                                             toItem: self,
                                                             constant: 16)
        NSLayoutConstraint.addEqualRightConstraintAndActivate(item: titleLabel,
                                                              toItem: self,
                                                              constant: .zero)
        NSLayoutConstraint.addEqualBottomConstraintAndActivate(item: titleLabel,
                                                               toItem: self,
                                                               constant: .zero)
    }
    
}

// MARK: - Configure UI
fileprivate extension SettingsCell {
    
    func configureUI() {
        configureView()
        configureTitleLabel()
    }
    
    func configureView() {
        self.backgroundColor = AppStyling.cellBackgroundColor()
    }
    
    func configureTitleLabel() {
        self.titleLabel.configure(withConfiguration: Self.titleLabelConfiguration)
    }
    
}
