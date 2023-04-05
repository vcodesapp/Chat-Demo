//
//  ChatView.swift
//  Chat Demo
//
//  Created by Mei Yang on 28/3/23.
//

import SwiftUI


struct ChatView: View {
    
    @ObservedObject var chatModel = ChatViewModel()
    @State var input = ""
    @State private var isInitialScroll = true
    @Namespace private var bottomID
    
    
    var body: some View {
        NavigationView{
            VStack(spacing:2){
                ScrollViewReader { proxy in
                    List{
                        Color.clear
                            .frame(height: 0)
                            .listRowSeparator(.hidden)
                            .onAppear{
                                print("\(nowms()): user scrolls to top")
                                print("\(nowms()): fetching more")
                                
                                print("\(nowms()): progress loading...")
                                if !chatModel.isLoading{ // if it is already loading, wait until last fetch to finish
                                    chatModel.isLoading = true
                                    
                                    chatModel.fetch{ firstMessageID in
                                        //completion
                                        chatModel.isLoading = false
                                        print("\(nowms()): finish loading...")
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                print("\(nowms()): scroll to first message")
                                                proxy.scrollTo(firstMessageID, anchor: .top)
                                            }
                                        }
                                    
                                    }
                                }
                            }

                        if(chatModel.isLoading){
                            HStack(){
                                
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                                    .scaleEffect(2)
                                    .frame(width: 50, height: 50, alignment: .center)
                                .listRowSeparator(.hidden)
                                Spacer()
                            }
                            
                        }
                        
                        ForEach(chatModel.messages.indices, id: \.self) { index in
                            let message = chatModel.messages[index]
                            MessageView(text: message.content, role: message.role)
                                .listRowSeparator(.hidden)
                                .id(message.id)
                                .onAppear {
                                    print("\(nowms()): message view \(index) appears")
                                }
                                
                        }
                        
                        Color.clear
                            .frame(height: 0)
                            .id(bottomID)
                            .listRowSeparator(.hidden)
                    }//End of List
                    
                    .listStyle(.plain)
                    .onChange(of: chatModel.messages) { _ in
                        if isInitialScroll {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    print("\(nowms()): scroll to bottom")
                                    isInitialScroll = false
                                    proxy.scrollTo(bottomID, anchor: .bottom)
                                
                                }
                            }
                        }
                    }
                }//end of scrollviewreader

                SendView(input: $input)
            } //end of VStack
            .navigationTitle("Chat")
            .onAppear{
                chatModel.fetch{ _ in
                    print("first fetch")
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }//end of Navigation
        .onAppear{
            isInitialScroll = true
            
        }
        .onDisappear{
            chatModel.messages.removeAll()
        
        }
    }//end of body
    
    
    func nowms() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter.string(from: now)
    }
    
}



struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}


struct SendView: View {
    
    @Binding var input: String
    
    var body: some View {
        VStack {
            // Your other views
            
            HStack {
                TextField("Enter your message", text: $input)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray), lineWidth: 1)
                    )
                    .ignoresSafeArea()
                
                Button(action: {
                    // Handle send action
                    
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.green)
                        .font(.system(size:26))
                }
            }
            .padding()
        }
    }
}
