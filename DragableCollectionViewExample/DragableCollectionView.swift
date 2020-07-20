//
//  DragableCollectionView.swift
//  DragableCollectionViewExample
//
//  Created by Jawad Ali on 15/07/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

public protocol DragableCollectionViewDelegate: AnyObject {
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath)
    func indexPathChanged(indexPath:IndexPath)
}

public class DragableCollectionView: UICollectionView {
    //MARK:- Properties
    public weak var dragableDelegate:DragableCollectionViewDelegate?
    private var lastIndex: IndexPath? = nil
    public var dropType: UICollectionViewDropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    // MARK:- init
    
    public convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, dropType: UICollectionViewDropProposal) {
         self.init(frame: frame, collectionViewLayout: layout)
        self.dropType = dropType
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK:- Configuration
    private func commonInit() {
        dragDelegate = self
        dropDelegate = self
        dragInteractionEnabled = true
    }
    
    
    
}

extension DragableCollectionView: UICollectionViewDragDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let previewParameters = UIDragPreviewParameters()
            previewParameters.visiblePath = UIBezierPath(roundedRect: CGRect(x: 10,y: 10,width: cell.bounds.width-20,height: cell.bounds.height-20), cornerRadius: 14)
            return previewParameters
        }
        return nil
    }
    
    public func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let provider = NSItemProvider()
        let item = UIDragItem(itemProvider: provider)
        
        // remove this code to drag whole cell
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        item.previewProvider  = { () -> UIDragPreview? in
            let previewImageView = UIView()
            previewImageView.frame =  CGRect(x: 0,y: 0,width: 50,height: 50)
            previewImageView.layer.cornerRadius = previewImageView.bounds.maxX / 2
            return UIDragPreview(view: previewImageView)
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        

        return [item]
    }
}

extension DragableCollectionView : UICollectionViewDropDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }

        dragableDelegate?.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath)
        print("drop:\(destinationIndexPath)")
    }
    
    public func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if lastIndex != destinationIndexPath {
            
            if let index = lastIndex {
                let cell = collectionView.cellForItem(at: index) as! DragableCollectionViewCell
                
                cell.removeShadow()
            }
            
            lastIndex = destinationIndexPath
        }
        
        if let index = destinationIndexPath {
            let cell = collectionView.cellForItem(at: index) as! DragableCollectionViewCell
            cell.addShadow()
            
        }
        return dropType
    }
    
}

