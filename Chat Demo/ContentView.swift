//
//  ContentView.swift
//  Chat Demo
//
//  Created by Mei Yang on 28/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(destination: ChatView()){
                    List{
                        Text("Enter Chat")
                    }
                }
            }
            .padding()
            .navigationTitle("Front")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
