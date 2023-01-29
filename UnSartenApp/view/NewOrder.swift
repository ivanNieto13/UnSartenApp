//
// Created by Ivan Nieto on 28/01/23.
//

import Foundation
import SwiftUI

struct NewOrder: View {
    @ObservedObject var newOrderService: NewOrderService
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        VStack {
            Text("Solcitar un platillo")
                .font(.title)
                .bold()
                .foregroundColor(Color("IconColor"))
                .padding(.bottom)
            Group {
                Text("Nombre del platillo")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
                TextField("Chilaquiles verdes", text: $newOrderService.orderName.toUnwrapped(defaultValue: ""))
                    .autocapitalization(.words)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .lineLimit(100)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            keyboardFocused = true
                        }
                    }
                    .onChange(of: newOrderService.orderName, perform: { value in
                        newOrderService.orderName = value
                    })
            }
            Group {
                Text("Presupuesto")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
                TextField("220.00", value: $newOrderService.orderBudget, format: .currency(code: .localizedName(of: .utf8)))
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .lineLimit(5)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .onChange(of: newOrderService.orderBudget, perform: { value in
                        newOrderService.orderBudget = value
                    })
            }
            Group {
                Text("Personas")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
                TextField("4", value: $newOrderService.orderPersons, format: .number)
                    .autocapitalization(.words)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .textFieldStyle(.automatic)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .lineLimit(2)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .onChange(of: newOrderService.orderPersons, perform: { value in
                        newOrderService.orderPersons = value
                    })
            }
            
            Group {
                Text("Posibles ingredientes")
                    .font(.title3)
                    .bold()
                    .frame(width: 300, alignment: .leading)
                TextField("Introduce algunos posibles ingredientes", text: $newOrderService.orderIngredients.toUnwrapped(defaultValue: ""))
                    .padding()
                    .frame(width: 300, height: 50)
                    .background()
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(0))
                    .keyboardType(.asciiCapable)
                    .lineLimit(100)
                    .foregroundColor(Color("TertiaryColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("TertiaryColor"), lineWidth: 2)
                    )
                    .onChange(of: newOrderService.orderIngredients, perform: { value in
                        newOrderService.orderIngredients = value
                    })
            }
            Group {
                Text("Agregar una foto de referencia")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("IconColor"))
                    .padding(.bottom)
                
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .foregroundColor(Color("MainColor"))
                        .frame(width: 100, height: 100)
                        .background(Color("PrimaryColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
            }
            
            Group {
                HStack {
                    Button("Regresar") {
                        print("Edit button was tapped")
                    }
                    .font(.title3)
                    .padding()
                    .foregroundColor(Color("PositiveButtonColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("PositiveButtonColor"), lineWidth: 2)
                    )
                    
                    Button("Crear solicitud") {
                        print("Edit button was tapped")
                    }
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding()
                    .background(Color("PositiveButtonColor"))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("PositiveButtonColor"), lineWidth: 5)
                    )
                    
                    
                }
            }.frame(maxHeight: .infinity, alignment: .bottom)
            
            Spacer()
        }
        
    }
    
}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct NewOrder_Previews: PreviewProvider {
    static var previews: some View {
        NewOrder(newOrderService: .init())
    }
}
