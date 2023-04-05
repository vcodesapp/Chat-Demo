//
//  MessageView.swift
//  Chat Demo
//
//  Created by Mei Yang on 28/3/23.
//

import SwiftUI

struct MessageView: View {
    
    var text: String
    var role: Role
    
    var body: some View {
        
        HStack{
            if(role == .user){
                Spacer()
            }
        
            Text(text)
                .font(.system(size: 16))
                .fontDesign(.rounded)
                .padding()
                .background(role == .user ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            if(role != .user){
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(text: "hi this is a chat", role:.user)
    }
}
