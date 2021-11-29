//
//  HistoryVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit

final class HistoryVC: UIViewController, UICollectionViewDelegate {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, SavedAnswer>!
    
    var items: [SavedAnswer] = []
    
    var viewModel: HistoryViewModel!
    
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
        
        viewModel.subscribeOnEventsForDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        items = viewModel.loadData()
        updateData(on: items)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.deleteData(for: indexPath.item)
        
        items.remove(at: indexPath.item)
        
        updateData(on: items)
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
            cell?.set(isLocal: item.isLocal, messageTitle: item.title!, version: item.version!, message: item.message!, dateTitle: (item.date?.convertToTimeMonthYearFormat()) ?? "")
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
