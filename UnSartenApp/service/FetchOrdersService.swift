//
//  FetchOrdersService.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import Foundation

class Order {
    var orderName: String = "Enchiladas verdes"
    var orderBudget: Float = 250.0
    var orderPersons: Int = 4
}

class FetchOrdersService: ObservableObject {
    @Published var orders: [Order]?
}
