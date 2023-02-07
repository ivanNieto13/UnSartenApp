//
// Created by Ivan Nieto on 06/02/23.
//

import Foundation
import SwiftUI
import Combine

final class NoURLService: ObservableObject {
    @Published var showInvalidURLServiceAlert = false

    func checkURLService() {
        if URLService().URL_SERVICES == URLService().URL_DEFAULT {
            showInvalidURLServiceAlert = true
        }
    }

}

struct NoURLServiceContentView: View {
    @Binding var showInvalidURLServiceAlert: Bool

    var body: some View {
        VStack {
            Text("Cambia la URL de servicios")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            Button(action: {
                showInvalidURLServiceAlert = true
            }) {
                Text("Reintentar")
                        .font(.title2)
                        .foregroundColor(.blue)
            }
        }
                .alert(isPresented: $showInvalidURLServiceAlert) {
                    Alert(title: Text("Cambia la URL de servicios"),
                            message: Text("Cambia la URL de servicios por la que se provee en la entrega, como lo dice en el README."),
                            dismissButton: .default(Text("OK")))
                }
    }

}
