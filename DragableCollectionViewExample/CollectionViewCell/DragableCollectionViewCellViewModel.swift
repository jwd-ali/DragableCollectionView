//
//  DragableCollectionViewCellViewModel.swift
//  DragableCollectionViewExample
//
//  Created by Jawad Ali on 12/07/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
protocol DragableCollectionViewCellViewModelType {
    func getImageName() -> String
}
class DragableCollectionViewCellViewModel {
    private let imageName: String
    
    init(imageName:String) {
        self.imageName = imageName
    }
}

extension DragableCollectionViewCellViewModel: DragableCollectionViewCellViewModelType {
    func getImageName() -> String {
        return self.imageName
    }
    
}
