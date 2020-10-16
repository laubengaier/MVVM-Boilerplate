//
//  InfoView.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 16.10.20.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            Text("Welcome").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("This ViewController\nis presented by SwiftUI!")
            .multilineTextAlignment(.center)
            Divider()
            Text("MVVM")
        }
        .padding(40)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
