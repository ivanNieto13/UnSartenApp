//
//  FetchOrders.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct OrderList: View {
    @Binding var allOrders: [GetOrder]

    var body: some View {
        List(allOrders, id: \.self) { order in
            //Text(order.orderName)
            OrderItem(orderName: order.orderName, orderBudget: Float(order.budget), orderPersons: order.persons)
        }
    }
}

struct FetchOrders: View {
    @ObservedObject var fetchOrdersService: FetchOrdersService
    @StateObject var getOrdersVM = GetOrdersViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Ver ordenes")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)

            if fetchOrdersService.orders.count > 0 {
                OrderList(allOrders: $fetchOrdersService.orders)
            } else {
                Text("No hay ordenes, crea una.")
                        .font(.body)
                        .bold()
                        .padding(.bottom)
            }
            Spacer()
        }
                .onChange(of: getOrdersVM.isLoading, perform: { value in
                    if !value {
                        fetchOrdersService.orders = getOrdersVM.getOrdersData.data.getOrders
                    }
                })
                .onAppear() {
                    getOrdersVM.isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        getOrdersVM.getOrders()
                    }

        }
    }
}

struct FetchOrders_Previews: PreviewProvider {
    static let service = FetchOrdersService()
    static var previews: some View {
        FetchOrders(fetchOrdersService: service)
    }
}
