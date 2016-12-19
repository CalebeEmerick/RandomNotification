//
//  HomeDataSource.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class HomeDataSource : NSObject {
    
    fileprivate let categories: [Category]
    
    override init() {
        
        categories = [
            .abstract, .city, .people, .transport, .animals, .food, .nature,
            .business, .nightlife, .sports, .cats, .fashion, .technics
        ]
        super.init()
    }
}

extension HomeDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CategoryCell = tableView.dequeueReusableCell(for: indexPath)
        let category = categories[indexPath.row]
        
        cell.category = category
        
        return cell
    }
}
