//
// Created by Ivan Nieto on 17/01/23.
//

import Foundation
import Combine

final class SaveUserDataViewModel: ObservableObject {
    @Published var saveUserData = SaveUserData(data: SUDataClass(saveUserData: SaveUserSUDataClass(userID: "", email: "", firstName: "", lastName: "", phoneNumber: ""), error: nil))
    @Published var error: URLError?
    @Published var isLoading = false

    @Published var home = false

    private let APIUrl = "http://Mac-mini-de-Ivan.local:3000/api/"
    private var cancellable = Set<AnyCancellable>()

    func saveUser(email: String, firstName: String, lastName: String, phoneNumber: String) {
        let verifyCodeUrlString = "\(APIUrl)login/saveUserData"
        guard let url = URL(string: verifyCodeUrlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let body = ["email": email, "firstName": firstName, "lastName": lastName, "phoneNumber": phoneNumber]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])

        return URLSession
                .shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap({ (data, response) -> Data in
                    let httpResponse = response as? HTTPURLResponse
                    return data
                })
                .decode(type: SaveUserData.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { saveUserData in
                    self.saveUserData = saveUserData
                    self.isLoading = false
                    if saveUserData.data.error != nil {
                        print("Error")
                    } else {
                        self.home = true
                    }
                })
                .store(in: &cancellable)
    }

}
