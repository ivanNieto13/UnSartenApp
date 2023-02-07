//
// Created by Ivan Nieto on 05/02/23.
//

import Foundation
import Combine

final class GetOrdersViewModel: ObservableObject {
    @Published var getOrdersData = GetOrders(data: GODataClass(getOrders: [], error: nil))
    @Published var error: URLError?
    @Published var isLoading = false

    private let APIUrl = URLService().URL_SERVICES + "api/"
    private var cancellable = Set<AnyCancellable>()

    func getOrders() {
        let verifyCodeUrlString = "\(APIUrl)orders/getOrders"
        guard let url = URL(string: verifyCodeUrlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return URLSession
                .shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap({ (data, response) -> Data in
                    let httpResponse = response as? HTTPURLResponse
                    return data
                })
                .decode(type: GetOrders.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { getOrdersData in
                    self.getOrdersData = getOrdersData
                    self.isLoading = false
                })
                .store(in: &cancellable)
    }

}
