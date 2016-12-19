//
//  Category.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import Foundation

enum Category {
    
    case abstract, city, people, transport, animals, food, nature, business, nightlife, sports, cats, fashion, technics
    
    var name: String {
        
        switch self {
            
        case .abstract:
            return "Abstrato"
        case .city:
            return "Cidade"
        case .people:
            return "Pessoas"
        case .transport:
            return "Transporte"
        case .animals:
            return "Animais"
        case .food:
            return "Comida"
        case .nature:
            return "Natureza"
        case .business:
            return "Negócios"
        case .nightlife:
            return "Vida Noturna"
        case .sports:
            return "Esportes"
        case .cats:
            return "Gatos"
        case .fashion:
            return "Moda"
        case .technics:
            return "Tecnologia"
        }
    }
    
    var image: String {
        
        switch self {
            
        case .abstract:
            return "abstract"
        case .city:
            return "city"
        case .people:
            return "people"
        case .transport:
            return "transport"
        case .animals:
            return "animals"
        case .food:
            return "food"
        case .nature:
            return "nature"
        case .business:
            return "business"
        case .nightlife:
            return "nightlife"
        case .sports:
            return "sports"
        case .cats:
            return "cats"
        case .fashion:
            return "fashion"
        case .technics:
            return "technics"
        }
    }
}
