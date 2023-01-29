//
//  NewOrderService.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import Foundation
class NewOrderService: ObservableObject {
    @Published var orderName: String?
    @Published var orderBudget: Float?
    @Published var orderPersons: Int?
    @Published var orderIngredients: String?
    @Published var orderTags: [Tag]?
    
}
