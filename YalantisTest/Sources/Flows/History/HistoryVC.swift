//
//  HistoryVC.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit

class HistoryVC: UIViewController, UICollectionViewDelegate {
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = viewModel.loadData().reversed()
        updateData(on: items)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // update screens' orientation or rotates
        collectionView.collectionViewLayout = UIHelper.createSingleColumnFlowLayout(in: view)
        collectionView.frame = view.bounds
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
                
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        collectionView.register(HistoryItemCell.self, forCellWithReuseIdentifier: CellsKey.historyCell)
        
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SavedAnswer>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsKey.historyCell, for: indexPath) as? HistoryItemCell
            cell?.set(isLocal: item.isLocal, messageTitle: item.title!, message: item.message!, dateTitle: (item.date?.convertToTimeMonthYearFormat())!)
            print(item.date)
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
