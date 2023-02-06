//
//  FetchOrders.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct OrderView: View {
    @Binding var order: GetOrder

    var body: some View {
        VStack {
            Text(order.orderName)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)

            Text(order.date)
                    .font(.body)
                    .padding(.bottom)

            Text("Presupuesto: $" + String(order.budget))
                    .font(.body)
                    .bold()
                    .foregroundColor(Color("PrimaryColor"))
                    .padding(.bottom)

            Text("Personas: " + String(order.persons))
                    .font(.body)
                    .bold()
                    .padding(.bottom)

            Text("Posibles ingredientes: " + order.optionalIngredients)
                    .font(.body)
                    .bold()
                    .padding(.bottom)

            Text("Solicitado por: " + order.author)
                    .font(.body)
                    .bold()
                    .padding(.bottom)

            if order.orderPicture != nil && order.orderPicture != "" {
                Group {
                    AsyncImage(url: URL(string: "http://mac-mini-de-ivan.local:3000/"+order.orderPicture!)) { image in
                        image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
                        .frame(width: 300, height: 300)

            }
            Spacer()
        }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)

    }
}


struct OrderList: View {
    @Binding var allOrders: [GetOrder]

    var body: some View {
        NavigationStack {
            List(allOrders, id: \.self) { order in
                NavigationLink(destination: OrderView(order: .constant(order))) {
                    OrderItem(orderName: order.orderName, orderBudget: Float(order.budget), orderPersons: order.persons)
                }
            }
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
