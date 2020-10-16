//
//  InfoView.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 16.10.20.
//

import SwiftUI

struct InfoView: View {
    
    let viewModel: InfoVM?
    
    init(viewModel: InfoVM? = nil) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            Text("Welcome").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("This ViewController\nis made with SwiftUI!")
            .multilineTextAlignment(.center)
            Divider()
            Button("Noice") {
                viewModel?.alertMessage = "This is a noice nonense message."
            }
            .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
            .background(Color(red: 0.8, green: 0.1, blue: 0.3))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        .padding(40)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
