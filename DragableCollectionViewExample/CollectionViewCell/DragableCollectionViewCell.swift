//
//  DragableCollectionViewCell.swift
//  DragableCollectionViewExample
//
//  Created by Jawad Ali on 12/07/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import UIKit
class DragableCollectionViewCell: UICollectionViewCell, ReusableView {
    
     // MARK: Views
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var background: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowColor = UIColor.clear.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    

    // MARK: Initialization
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
       
       private func commonInit() {
           setupViews()
           setupConstraints()
       }
    
    // MARK: Configurations
       
        func configure(with viewModel: Any) {
           guard let viewModel = viewModel as? DragableCollectionViewCellViewModelType else { return }
            self.profileImage.image = UIImage(named: viewModel.getImageName())
           
       }
    
}

// MARK: View setup

private extension DragableCollectionViewCell {
    func setupViews() {
        
        contentView.addSubview(background)
        background.addSubview(profileImage)
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        
    }
    
    func setupConstraints() {
        
        background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        background.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        background.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        
        profileImage.topAnchor.constraint(equalTo: background.topAnchor).isActive = true
        profileImage.rightAnchor.constraint(equalTo: background.rightAnchor).isActive = true
        profileImage.leftAnchor.constraint(equalTo: background.leftAnchor).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: background.bottomAnchor).isActive = true
    }
}


extension DragableCollectionViewCell {

func addShadow(){
       background.layer.shadowColor = UIColor.black.cgColor
       background.clipsToBounds = false
   }
   func removeShadow(){
     background.layer.shadowColor = UIColor.clear.cgColor
       background.clipsToBounds = true
   }
}
