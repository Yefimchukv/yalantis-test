//
//  HistoryVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class HistoryVC: UIViewController, UICollectionViewDelegate {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, SavedAnswer>!
    
    var viewModel: HistoryViewModel!
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: HistoryViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
        
        configureBindings()
        viewModel.subscribeOnEventsForDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadData()
        updateData(on: viewModel.items)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    private func configureBindings() {
        collectionView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            guard let self = self else { return }
            
            self.viewModel.deleteData(for: index.item).flatMap { () -> Observable<Void> in
                self.viewModel.items.remove(at: index.item)
                self.updateData(on: self.viewModel.items)
                return .just(())
            }.subscribe().disposed(by: self.disposeBag)

        }).disposed(by: disposeBag)
    }
}

// MARK: - CollectionView configures
private extension HistoryVC {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createSingleColumnCompositionalLayout())
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        collectionView.register(HistoryItemCell.self, forCellWithReuseIdentifier: CellsKey.historyCell)
        
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SavedAnswer>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsKey.historyCell, for: indexPath) as? HistoryItemCell
            cell?.set(isLocal: item.isLocal, messageTitle: item.title, version: item.version, message: item.message, dateTitle: item.date?.convertToTimeMonthYearFormat())
            return cell
        })
    }
    
    func updateData(on items: [SavedAnswer]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SavedAnswer>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
