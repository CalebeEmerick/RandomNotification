//
//  HomeDelegate.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class HomeDelegate : NSObject {

    var categorySelected: ((Category, IndexPath) -> Void)?
    fileprivate var category: Category?
}

extension HomeDelegate : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else { return }
        guard let category = cell.category else { return }
        guard self.category != category else { return }
        
        self.categorySelected?(category, indexPath)
        self.category = category
    }
}
