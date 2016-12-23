//
//  HomePresenter.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import Foundation

struct HomePresenter {
    
    private let service = Service()
    private weak var homeView: HomeView?
    
    init(view: HomeView) {
        self.homeView = view
    }
    
    func showNotification(from category: Category, isGrayScale: Bool) {
        
        homeView?.showLoading()
        homeView?.lockUI()
        
        service.getImage(from: category, isGrayScale: isGrayScale) { image in
            
            guard let image = image else {
                
                self.homeView?.hideLoading()
                self.homeView?.unlockUI()
                self.homeView?.showAlert(with: "Não foi possível carregar a imagem 🙁. Verifique sua conexão e tente novamente.")
                return
            }
            
            self.homeView?.showNotification(from: category, with: image)
            self.homeView?.hideLoading()
            self.homeView?.unlockUI()
        }
    }
}
