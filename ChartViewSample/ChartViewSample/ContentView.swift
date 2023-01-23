//
//  ContentView.swift
//  ChartViewSample
//
//  Created by 岩田照太 on 2021/04/21.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            ChatListView()
            
        }
    }
}

struct ChatUser {
    let uid, email, profileImageUrl: String
}

struct ChatListView: View {
    @State var chatUser: ChatUser?

       @State var chatText = ""
       @State var value: ScrollViewProxy?
       var body: some View {
           ZStack {
               messagesView
               VStack(spacing: 0) {
                   Spacer()
                   chatBottomBar
                       .background(Color.white.ignoresSafeArea())
               }
           }
           .navigationTitle(chatUser?.email ?? "")
               .navigationBarTitleDisplayMode(.inline)
       }

       private var messagesView: some View {
           ScrollView {
               ForEach(0..<20) { num in
                   HStack {
                       Spacer()
                       HStack {
                           Text("FAKE MESSAGE FOR NOW")
                               .foregroundColor(.white)
                       }
                       .padding()
                       .background(Color.gray)
                       .cornerRadius(20)
                   }
                   .padding(.horizontal)
                   .padding(.top, 8)
               }

               HStack{ Spacer() }
               .frame(height: 50)
           }
           .background(Color(.init(white: 0.95, alpha: 1)))

       }

       private var chatBottomBar: some View {
           HStack(spacing: 5) {
               ZStack {
                   TextEditor(text: $chatText)
                       .opacity(chatText.isEmpty ? 0.5 : 1)
               }
               .frame(height: 40)
               .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gray.opacity(0.4)))
               .padding(.leading, 20)
               Button {

               } label: {
                   Image(systemName: "paperplane.fill")
                       .foregroundColor(.black)
               }
               .padding(.horizontal)
               .padding(.vertical, 8)
               
           }
           .padding(.horizontal)
           .padding(.vertical, 8)
       }
}

struct MessagesView: View {

    @State var shouldShowLogOutOptions = false
    @State var showMessage = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            VStack {
                messagesView
            }
        NavigationLink(destination:ChatListView() ,isActive: $showMessage) {}
        }.navigationTitle("メッセージ")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ZStack {
                        Circle()
                            .frame(width: 38, height: 38)
                            //.foregroundColor(Color(Brand.color(for: .background(.primary))))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 3)
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("chevron.left")
                                //.foregroundColor(Color(Brand.color(for: .background(.secondary))))
                                .offset(x: 2)
                        }
                    }
                }
            }
           
    }

    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                Button {
                    showMessage.toggle()
                } label: {
                    VStack {
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                            .stroke(Color(.label), lineWidth: 1)
                                )


                            VStack(alignment: .leading) {
                                Text("Username")
                                    .font(.system(size: 16, weight: .bold))
                                Text("Message sent to user")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                            }
                            Spacer()

                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        Divider()
                            .padding(.vertical, 8)
                    }.padding(.horizontal)
                }

            }.padding(.bottom, 50)
        }
    }
}
private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Description")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack {
            //if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
//                HStack {
//                    Spacer()
//                    HStack {
//                        Text(message.text)
//                            .foregroundColor(.white)
//                    }
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(8)
//                }
            //} else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    Spacer()
                }
            //}
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}


class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    @Published var chatMessages = [ChatMessage]()
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        
        //fetchMessages()
    }
    
//    private func fetchMessages() {
//        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        guard let toId = chatUser?.uid else { return }
//        FirebaseManager.shared.firestore
//            .collection(FirebaseConstants.messages)
//            .document(fromId)
//            .collection(toId)
//            .order(by: FirebaseConstants.timestamp)
//            .addSnapshotListener { querySnapshot, error in
//                if let error = error {
//                    self.errorMessage = "Failed to listen for messages: \(error)"
//                    print(error)
//                    return
//                }
//
//                querySnapshot?.documentChanges.forEach({ change in
//                    if change.type == .added {
//                        let data = change.document.data()
//                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
//                    }
//                })
//
//                DispatchQueue.main.async {
//                    self.count += 1
//                }
//            }
//    }
    
//    func handleSend() {
//        print(chatText)
//        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//        guard let toId = chatUser?.uid else { return }
//
//        let document = FirebaseManager.shared.firestore.collection(FirebaseConstants.messages)
//            .document(fromId)
//            .collection(toId)
//            .document()
//
//        let messageData = [FirebaseConstants.fromId: fromId, FirebaseConstants.toId: toId, FirebaseConstants.text: self.chatText, FirebaseConstants.timestamp: Timestamp()] as [String : Any]
//
//        document.setData(messageData) { error in
//            if let error = error {
//                print(error)
//                self.errorMessage = "Failed to save message into Firestore: \(error)"
//                return
//            }
//
//            print("Successfully saved current user sending message")
//            self.chatText = ""
//            self.count += 1
//        }
        
//        let recipientMessageDocument = FirebaseManager.shared.firestore.collection("messages")
//            .document(toId)
//            .collection(fromId)
//            .document()
//
//        recipientMessageDocument.setData(messageData) { error in
//            if let error = error {
//                print(error)
//                self.errorMessage = "Failed to save message into Firestore: \(error)"
//                return
//            }
//
//            print("Recipient saved message as well")
//        }
//    }
    
    @Published var count = 0
}

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    var body: some View {
        ZStack {
            messagesView
            Text(vm.errorMessage)
        }
        .navigationTitle(chatUser?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(trailing: Button(action: {
//                vm.count += 1
//            }, label: {
//                Text("Count: \(vm.count)")
//            }))
    }
    
    static let emptyScrollToString = "Empty"
    
    private var messagesView: some View {
        VStack {
            if #available(iOS 15.0, *) {
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack {
                            ForEach(vm.chatMessages) { message in
                                MessageView(message: message)
                            }
                            
                            HStack{ Spacer() }
                            .id(Self.emptyScrollToString)
                        }
                        .onReceive(vm.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                .background(Color(.init(white: 0.95, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBottomBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {
                //vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
