//
//  ChatViewModel.swift
//  Chat Demo
//
//  Created by Mei Yang on 28/3/23.
//

import Foundation

import Combine

var pool = [
    Message(content: "hi", role: .user, timestamp: getMinuteBefore(20)),
    Message(content: "hi how can I help you?", role: .assistant, timestamp: getMinuteBefore(19)),
    Message(content: "hi 2", role: .user, timestamp: getMinuteBefore(18)),
    Message(content: "hi how can I help you? 2", role: .assistant, timestamp: getMinuteBefore(17)),
    Message(content: "hi 3", role: .user, timestamp: getMinuteBefore(16)),
    Message(content: "hi how can I help you? 3", role: .assistant, timestamp: getMinuteBefore(15)),
    Message(content: "hi 4", role: .user, timestamp: getMinuteBefore(14)),
    Message(content: "hi how can I help you? 4", role: .assistant, timestamp: getMinuteBefore(13)),
    Message(content: "hi 5", role: .user, timestamp: getMinuteBefore(12)),
    Message(content: "hi how can I help you? 5", role: .assistant, timestamp: getMinuteBefore(11)),
    Message(content: "hi 6", role: .user, timestamp: getMinuteBefore(10)),
    Message(content: "hi how can I help you? 6", role: .assistant, timestamp: getMinuteBefore(9)),
    Message(content: "hi 7", role: .user, timestamp: getMinuteBefore(8)),
    Message(content: "hi how can I help you? 7", role: .assistant, timestamp: getMinuteBefore(7)),
    Message(content: "hi 8", role: .user, timestamp: getMinuteBefore(6)),
    Message(content: "hi how can I help you? 8", role: .assistant, timestamp: getMinuteBefore(5)),
    Message(content: "hi 9", role: .user, timestamp: getMinuteBefore(4)),
    Message(content: "hi how can I help you? 9", role: .assistant, timestamp: getMinuteBefore(3)),
    Message(content: "hi 10", role: .user, timestamp: getMinuteBefore(2)),
    Message(content: "hi how can I help you? 10", role: .assistant, timestamp: getMinuteBefore(1)),
    Message(content: "hi 11", role: .user, timestamp: getMinuteBefore(0)),
    Message(content: "hi how can I help you? 11", role: .assistant, timestamp: getMinuteBefore(-1)),
    Message(content: "hi 12", role: .user, timestamp: getMinuteBefore(-2)),
    Message(content: "hi how can I help you? 12", role: .assistant, timestamp: getMinuteBefore(-3)),
    Message(content: "hi 13", role: .user, timestamp: getMinuteBefore(-4)),
    Message(content: "hi how can I help you? 13", role: .assistant, timestamp: getMinuteBefore(-5)),
    Message(content: "hi 14", role: .user, timestamp: getMinuteBefore(-6)),
    Message(content: "hi how can I help you? 14", role: .assistant, timestamp: getMinuteBefore(-7)),
    Message(content: "hi 15", role: .user, timestamp: getMinuteBefore(-8)),
    Message(content: "hi how can I help you? 15", role: .assistant, timestamp: getMinuteBefore(-9)),
    Message(content: "hi 16", role: .user, timestamp: getMinuteBefore(-10)),
    Message(content: "hi how can I help you? 16", role: .assistant, timestamp: getMinuteBefore(-11)),
    Message(content: "hi 17", role: .user, timestamp: getMinuteBefore(-12)),
    Message(content: "hi how can I help you? 17", role: .assistant, timestamp: getMinuteBefore(-13)),



]

func getMinuteBefore(_ minutes: Int) -> Date{
    let calendar = Calendar.current
    let before = calendar.date(byAdding: .minute, value: -minutes, to: Date())
            
    return before ?? Date()
}

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var isLoading = false
    
    func fetch(_ num: Int = 12, completion: @escaping (Message.ID?) -> Void) {
        
        print("ChatViewModel: \(Date()) - fetching messages..")
        print("ChatViewModel: current messages count - \(messages.count)")
        
        let firstMessageID = self.messages.first?.id
        /**
         sorting: earliest (index=0) -> most recent (index= last)
         */
        let sortedMessages = pool.sorted { $0.timestamp < $1.timestamp }
        
        var lastMessageIndex = pool.count - 1
        if (messages.count > 0){ //when there are messages
            let last = messages.first!
            lastMessageIndex = sortedMessages.firstIndex(where: { $0.id == last.id})!
//            print("Having messages - last message index: \(lastMessageIndex)")
        }
        
        let startIndex = max(0, lastMessageIndex - num)
        /**
         fetch 'num' of messages in each fetch
         */
        
        let nextMessages = sortedMessages[startIndex..<lastMessageIndex]
        
        /**
         insert before the old messages
         */
        messages.insert(contentsOf: nextMessages, at: 0)
        
        completion(firstMessageID)
    }
    
    
}
