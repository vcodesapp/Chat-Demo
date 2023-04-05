//
//  demo.swift
//  Chat Demo
//
//  Created by Mei Yang on 5/4/23.
//

import SwiftUI

struct demo: View {
    var body: some View {
        VStack{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                .scaleEffect(2)
                .frame(width: 50, height: 50, alignment: .center)
                .listRowSeparator(.hidden)
        }
    }
}

struct demo_Previews: PreviewProvider {
    static var previews: some View {
        demo()
    }
}
