//
// Created by Ivan Nieto on 16/01/23.
//

import Foundation
import Combine

final class VerifyNumberViewModel: ObservableObject {
    @Published var verifyNumber = VerifyNumber(data: DataClass(verifyNumber: VerifyNumberClass(phoneNumber: "", isVerified: false, userID: ""), error: nil))
    @Published var error: URLError?
    @Published var isLoading = false

    @Published var verifyCode: VerifyCode?

    @Published var confirmCode = false

    private let APIUrl = "http://Mac-mini-de-Ivan.local:3000/api/"
    private var cancellable = Set<AnyCancellable>()

    func verifyPhone(phoneNumber: String) {
        isLoading = true
        if self.verifyNumber.data.verifyNumber.phoneNumber == phoneNumber {
            confirmCode = true
            isLoading = false
            return
        }
        let verifyNumberUrlString = "\(APIUrl)login/verifyNumber"
        guard let url = URL(string: verifyNumberUrlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let body = ["phoneNumber": phoneNumber]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])

        return URLSession
                .shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap({ (data, response) -> Data in
                    let httpResponse = response as? HTTPURLResponse
                    return data
                })
                .decode(type: VerifyNumber.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { verifyNumber in
                    self.confirmCode = true
                    self.isLoading = false
                    self.verifyNumber = verifyNumber
                })
                .store(in: &cancellable)

    }


}
