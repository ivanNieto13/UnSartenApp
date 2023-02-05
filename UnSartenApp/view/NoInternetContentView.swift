//
// Created by Ivan Nieto on 04/02/23.
//

import SwiftUI
import Network

final class NoInternet: ObservableObject {
    @Published var showNoInternetAlert = false
    @Published var showMobileDataUsage = false

    func checkConnectivity() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [self] path in
            if path.status != .satisfied {
                showNoInternetAlert = true
            } else {
                showNoInternetAlert = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

}

struct NoInternetContentView: View {
    @Binding var showNoConnectionAlert: Bool

    var body: some View {
        VStack {
            Text("No hay conexión a internet")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
            Button(action: {
                showNoConnectionAlert = true
            }) {
                Text("Reintentar")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .alert(isPresented: $showNoConnectionAlert) {
            Alert(title: Text("No hay conexión a internet"),
                  message: Text("Por favor, revisa tu conexión a internet e intenta nuevamente."),
                  dismissButton: .default(Text("OK")))
        }
    }

}
