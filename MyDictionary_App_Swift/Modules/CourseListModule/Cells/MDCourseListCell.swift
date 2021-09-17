//
//  MDCourseListCell.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.09.2021.
//

import UIKit

final class MDCourseListCell: UICollectionViewCell,
                              ReuseIdentifierProtocol {
    
    fileprivate static let titleLabelLeftOffset: CGFloat = 16
    fileprivate static let titleLabelRightOffset: CGFloat = 16
    fileprivate let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.font = MDAppStyling.Font.MyriadProRegular.font(ofSize: 17)
        label.textAlignment = .left
        label.textColor = MDAppStyling.Color.md_Black_1_Light_Appearence.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate static let arrowImageViewSize: CGSize = .init(width: 32, height: 32)
    fileprivate static let arrowImageViewRightOffset: CGFloat = 4
    fileprivate let arrowImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.image = MDAppStyling.Image.right_arrow.image
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate static let bottomLineViewHeight: CGFloat = 0.5
    fileprivate let bottomLineView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = MDAppStyling.Color.light_Gray_0.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public static let height: CGFloat = 48
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
}

// MARK: - FillWithModelProtocol
extension MDCourseListCell: FillWithModelProtocol {
    
    typealias Model = MDCourseListCellModel?
    
    func fillWithModel(_ model: MDCourseListCellModel?) {
        self.titleLabel.text = model?.languageName
    }
    
}

// MARK: - Add Views
fileprivate extension MDCourseListCell {
    
    func addViews() {
        addTitleLabel()
        addArrowImageView()
        addBottomLineView()
    }
    
    func addTitleLabel() {
        addSubview(titleLabel)
    }
    
    func addArrowImageView() {
        addSubview(arrowImageView)
    }
    
    func addBottomLineView() {
        addSubview(bottomLineView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension MDCourseListCell {
    
    func addConstraints() {
        addTitleLabelConstraints()
        addArrowImageViewConstraints()
        addBottomLineViewConstraints()
    }
    
    func addTitleLabelConstraints() {
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.titleLabel,
                                                  toItem: self,
                                                  constant: Self.titleLabelLeftOffset)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .centerY,
                                              toItem: self.arrowImageView,
                                              attribute: .centerY,
                                              constant: .zero)
        
        NSLayoutConstraint.addEqualConstraint(item: self.titleLabel,
                                              attribute: .right,
                                              toItem: self.arrowImageView,
                                              attribute: .left,
                                              constant: -Self.titleLabelRightOffset)
        
    }
    
    func addArrowImageViewConstraints() {
        
        NSLayoutConstraint.addEqualCenterYConstraint(item: self.arrowImageView,
                                                     toItem: self,
                                                     constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.arrowImageView,
                                                   toItem: self,
                                                   constant: -Self.arrowImageViewRightOffset)
        
        NSLayoutConstraint.addEqualWidthConstraint(item: self.arrowImageView,
                                                   constant: Self.arrowImageViewSize.width)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.arrowImageView,
                                                    constant: Self.arrowImageViewSize.height)
        
    }
    
    func addBottomLineViewConstraints() {
        
        NSLayoutConstraint.addEqualBottomConstraint(item: self.bottomLineView,
                                                    toItem: self,
                                                    constant: .zero)
        
        NSLayoutConstraint.addEqualLeftConstraint(item: self.bottomLineView,
                                                  toItem: self.titleLabel,
                                                  constant: .zero)
        
        NSLayoutConstraint.addEqualRightConstraint(item: self.bottomLineView,
                                                   toItem: self,
                                                   constant: .zero)
        
        NSLayoutConstraint.addEqualHeightConstraint(item: self.bottomLineView,
                                                    constant: Self.bottomLineViewHeight)
        
    }
    
}
