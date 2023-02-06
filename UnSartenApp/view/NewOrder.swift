//
// Created by Ivan Nieto on 28/01/23.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

struct NewOrder: View {
    @ObservedObject var newOrderService: NewOrderService

    @StateObject private var saveOrderDataVM = SaveOrderDataViewModel()
    @State var showCreateOrderButtonActive = false
    @State var showingAlert = false
    @State var validOrderName = false
    @State var validBudget = false
    @State var validPersons = false
    @State var validIngredients = false

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    let coreDM: CoreDataManager
    let budgetLimit = 5


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
                        .onChange(of: newOrderService.orderName, perform: { value in
                            newOrderService.orderName = value
                            if value?.count ?? 0 > 0 {
                                validOrderName = true
                            } else {
                                validOrderName = false
                            }
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
                        .border(.red, width: CGFloat(0))
                        .keyboardType(.decimalPad)
                        .lineLimit(1)
                        .foregroundColor(Color("TertiaryColor"))
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("TertiaryColor"), lineWidth: 2)
                        )
                        .onChange(of: newOrderService.orderBudget, perform: { value in
                            newOrderService.orderBudget = value
                            if value ?? 0 > 0 {
                                validBudget = true
                            } else {
                                validBudget = false
                            }
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
                        .keyboardType(.numberPad)
                        .lineLimit(1)
                        .foregroundColor(Color("TertiaryColor"))
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("TertiaryColor"), lineWidth: 2)
                        )
                        .onChange(of: newOrderService.orderPersons, perform: { value in
                            newOrderService.orderPersons = value
                            if value ?? 0 > 0 {
                                validPersons = true
                            } else {
                                validPersons = false
                            }
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
                            if value?.count ?? 0 > 0 {
                                validIngredients = true
                            } else {
                                validIngredients = false
                            }
                        })
            }
            Group {
                Text("Agregar una foto de referencia")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("IconColor"))
                        .padding(.bottom)

                HStack {
                    PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                        Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .foregroundColor(Color("MainColor"))
                                .frame(width: 100, height: 100)
                                .background(Color("PrimaryColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }

                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                    }
                }
            }

            Group {
                HStack {
                    Button(action: {
                        showingAlert = showCreateOrderButtonActive
                    }) {
                        switch showCreateOrderButtonActive {
                        case true:
                            Text("Crear orden")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color("PrimaryColor"))
                                    .cornerRadius(10)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("PositiveButtonColor"), lineWidth: 5)
                                    )
                        case false:
                            Text("Crear orden")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(.lightGray))
                                    .cornerRadius(10)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color(.lightGray), lineWidth: 5)
                                    )
                        }
                    }



                }
                        .onChange(of: validIngredients && validBudget && validOrderName && validPersons, perform: { navigate in
                            if navigate {
                                showCreateOrderButtonActive = navigate
                            } else {
                                showCreateOrderButtonActive = navigate
                            }
                        })
                        .alert("Crear orden", isPresented: $showingAlert) {
                            Button("Editar", role: .cancel) {
                            }
                            Button("Crear", role: .destructive) {
                                let data = coreDM.getUserData()
                                let author = (data?.firstName ?? "") + " " + (data?.lastName ?? "")
                                var imageString = ""
                                if selectedImageData != nil {
                                    imageString = "data:image/jpeg"+";base64," + (selectedImageData?.base64EncodedString() ?? "")
                                }
                                DispatchQueue.main.async {
                                    saveOrderDataVM.saveOrder(
                                            userId: data?.userId ?? "",
                                            orderName: newOrderService.orderName ?? "",
                                            budget: newOrderService.orderBudget ?? 0.0,
                                            persons: Int(newOrderService.orderPersons ?? 1),
                                            author: author,
                                            optionalIngredients: newOrderService.orderIngredients ?? "",
                                            orderPicture: imageString
                                    )
                                }
                            }
                        } message: {
                            Text("Estas seguro de crear la orden?")
                        }
            }
                    .frame(maxHeight: .infinity, alignment: .bottom)

            Spacer()
        }
                .onChange(of: saveOrderDataVM.viewOrders, perform: { viewOrders in
                    if viewOrders {
                        resetInputs()
                        saveOrderDataVM.viewOrders = false
                        //presentationMode.wrappedValue.dismiss(
                    }
                })



    }

    private func resetInputs() {
        newOrderService.orderName = ""
        newOrderService.orderBudget = 0.0
        newOrderService.orderPersons = 0
        newOrderService.orderIngredients = ""
        validOrderName = false
        validBudget = false
        validPersons = false
        validIngredients = false
        showCreateOrderButtonActive = false
    }

}

extension Binding {
    func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct NewOrder_Previews: PreviewProvider {
    static var previews: some View {
        NewOrder(newOrderService: .init(), coreDM: CoreDataManager())
    }
}
