//
//  SaveOrderDataViewModel.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 05/02/23.
//

import Foundation
import Combine

final class SaveOrderDataViewModel: ObservableObject {
    @Published var saveOrderData = SaveOrderData(
        data: SODataClass(
                SaveOrderData: SaveOrderDataClass(
                userId: "", orderName: "", budget: 1.50, persons: 4, orderPicture: nil, orderStatus: "", author: "", date: "", optionalIngredients: ""), error: nil))
    @Published var error: URLError?
    @Published var viewOrders: Bool = false


    private let APIUrl = "http://Mac-mini-de-Ivan.local:3000/api/"
    private var cancellable = Set<AnyCancellable>()

    func saveOrder(
            userId: String, orderName: String, budget: Float, persons: Int, author: String, optionalIngredients: String, orderPicture: String) {
        let verifyNumberUrlString = "\(APIUrl)orders/saveOrderData"
        guard let url = URL(string: verifyNumberUrlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let body = [
            "userId": userId,
            "orderName": orderName,
            "budget": budget,
            "persons": persons,
            "author": author,
            "optionalIngredients": optionalIngredients,
            "orderPicture": orderPicture
        ] as [String: Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])

        return URLSession
                .shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap({ (data, response) -> Data in
                    let httpResponse = response as? HTTPURLResponse
                    return data
                })
                .decode(type: SaveOrderData.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { saveOrderData in
                    self.viewOrders = true
                    self.saveOrderData = saveOrderData
                })
                .store(in: &cancellable)

    }


}

