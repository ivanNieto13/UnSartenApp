//
//  FetchOrders.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct FetchOrders: View {
    @ObservedObject var fetchOrdersService: FetchOrdersService
    
    var orders = [Order()]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Ver ordenes")
                .font(.title)
                .bold()
                .foregroundColor(Color("IconColor"))
                .padding(.bottom)
            
            if orders.count > 0 {
                ForEach(0 ..< orders.count) { value in
                    OrderItem(orderName: orders[value].orderName, orderBudget: orders[value].orderBudget, orderPersons: orders[value].orderPersons)
                }
            } else {
                Text("No hay ordenes, crea una.")
                    .font(.body)
                    .bold()
                    .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct FetchOrders_Previews: PreviewProvider {
    static let service = FetchOrdersService()
    static var previews: some View {
        FetchOrders(fetchOrdersService: service)
    }
}
