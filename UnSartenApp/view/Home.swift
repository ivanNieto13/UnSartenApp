//
// Created by Ivan Nieto on 23/01/23.
//

import SwiftUI

struct HomeContentView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        if (/*getHomeDataViewModel.isLoading*/ !true) {
            ZStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("IconColor")))
                
                // TODO - make color from assets colors
                    .background(Color("PrimaryColor"))
                Color(.black)
                // TODO - make this opacity from a constant
                    .opacity(0.1)
                    .ignoresSafeArea()
            }
            .onAppear() {
                print("HomeContentView - onAppear")
            }
            
            .navigationBarBackButtonHidden(true)
        } else {
            TabBar()
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
