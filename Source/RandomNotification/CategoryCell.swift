//
//  CategoryCell.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class CategoryCell : UITableViewCell {

    @IBOutlet fileprivate weak var picture: UIImageView!
    @IBOutlet fileprivate weak var name: UILabel!
    
    var category: Category? { didSet { updateUI() } }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.accessoryType = selected ? .checkmark : .none
    }
    override var isSelected: Bool {
        get { return super.isSelected }
        set { setSelected(newValue, animated: true) }
    }
}

extension CategoryCell {
    
    func deselectItem() {
        
        super.isSelected = false
        super.accessoryType = .none
    }
    
    fileprivate func updateUI() {
        
        guard let category = category else { return }
        
        set(category: category)
    }

    private func set(category: Category) {
        
        DispatchQueue.main.async {
            
            self.picture.image = UIImage(named: category.image)
            self.name.text = category.name
        }
    }
}
