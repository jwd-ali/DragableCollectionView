//
//  MainViewController.swift
//  DragableCollectionViewExample
//
//  Created by Jawad Ali on 12/07/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIDropInteractionDelegate {
    
    // MARK: Views
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    
    private lazy var collectionView: DragableCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = DragableCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.9628635049, green: 0.9730039239, blue: 0.9682733417, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dragInteractionEnabled = true
       // collectionView.dragableDelegate = self
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    // MARK: - Properties
    
    private let viewModel: MainViewModelType
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        view.addInteraction(UIDropInteraction(delegate: self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("appear")
        self.view.backgroundColor = .green
    }
    
    // MARK: - Init
    
    init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
private extension MainViewController {
    func setupViews() {
        
        view.addSubview(collectionView)
        
        collectionView.register(DragableCollectionViewCell.self, forCellWithReuseIdentifier: DragableCollectionViewCell.reuseIdentifier)
        
    }
    func setupConstraints() {
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DragableCollectionViewCell.reuseIdentifier, for: indexPath) as! DragableCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let cellModel = DragableCollectionViewCellViewModel(imageName: items[indexPath.item])
        cell.configure(with: cellModel)
        //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        true
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width ) / 2
        let height = width * 0.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainViewController : DragableCollectionViewDelegate {
    func indexPathChanged(indexPath: IndexPath) {
        print("index changed")
    }
    
     func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath)
    {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath {
            var dIndexPath = destinationIndexPath
            if dIndexPath.row >= collectionView.numberOfItems(inSection: 0) {
                dIndexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                
//                    self.items.remove(at: sourceIndexPath.row)
//                    self.items.insert(item.dragItem.localObject as! String, at: dIndexPath.row)
                
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [dIndexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: dIndexPath)
        }
    }
}
