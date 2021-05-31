//
//  SettingsViewController.swift
//  MyDictionary_App_Swift
//
//  Created Dmytro Chumakov on 31.05.2021.

import UIKit

final class SettingsViewController: UIViewController {

    fileprivate let presenter: SettingsPresenterInputProtocol

    fileprivate let collectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = .init()
        let collectionView = UICollectionView.init(frame: .zero,
                                                   collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    init(presenter: SettingsPresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraints()
    }

}

// MARK: - SettingsPresenterOutputProtocol
extension SettingsViewController: SettingsPresenterOutputProtocol {
       
    func scrollToTop() {
        collectionView.scrollToItem(at: .init(item: .zero,
                                              section: .zero),
                                    at: .top,
                                    animated: true)
    }
    
}

// MARK: - Add Views
fileprivate extension SettingsViewController {
    
    func addViews() {
        addCollectionView()
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
    }
    
}

// MARK: - Add Constraints
fileprivate extension SettingsViewController {
    
    func addConstraints() {
        addCollectionConstraints()
    }
    
    func addCollectionConstraints() {
        NSLayoutConstraint.addItemEqualToItemAndActivate(item: self.collectionView,
                                                         toItem: self.view)
    }
    
}

// MARK: - Configure UI
fileprivate extension SettingsViewController {
    
    func configureUI() {
        configureView()
        configureCollectionView()
    }
    
    func configureView() {
        self.view.backgroundColor = AppStyling.Color.systemWhite.color()
        self.title = KeysForTranslate.settings.localized
    }
    
    func configureCollectionView() {
        self.collectionView.delegate = self.presenter.collectionViewDelegate
        self.collectionView.dataSource = self.presenter.collectionViewDataSource
        self.collectionView.register(SettingsCell.self)
        self.collectionView.backgroundColor = AppStyling.Color.systemWhite.color()
    }

}
