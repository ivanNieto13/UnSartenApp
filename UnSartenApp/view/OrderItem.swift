//
//  OrderItem.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 29/01/23.
//

import SwiftUI

struct OrderItem: View {
    var orderName: String
    var orderBudget: Float
    var orderPersons: Int
    
    var body: some View {
        return Group {
            
            VStack(alignment: .leading) {
                Text(orderName)
                    .font(.headline)
                    .foregroundColor(Color("IconColor"))
                HStack {
                    Text("$" + String(orderBudget))
                        .font(.subheadline)
                    Spacer()
                    Text(String(orderPersons) + " personas")
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}

struct OrderItem_Previews: PreviewProvider {
    static var previews: some View {
        OrderItem(
            orderName: "Enchiladas verdes",
            orderBudget: 250.00,
            orderPersons: 4
            
        )
    }
}
