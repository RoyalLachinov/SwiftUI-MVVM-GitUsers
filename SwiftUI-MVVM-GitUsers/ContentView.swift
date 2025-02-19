//
//  ContentView.swift
//  SwiftUI-MVVM-GitUsers
//
//  Created by Royal Lachinov on 2025-02-18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                List {
                    ForEach(userViewModel.userList ?? [], id: \.id) { gitUser in
                        userListItem(gitUser: gitUser)
                    }
                }
                //.padding()
                .task {
                    do {
                        await userViewModel.fetchUser()
                    } catch  ErrorCases.invalidUrl {
                        print("Invalid UrL")
                    } catch ErrorCases.invalidResponse {
                        print("Invalid Response")
                    } catch ErrorCases.invalidData {
                        print("Invalid Data")
                    } catch {
                        print("Something went wrong")
                    }
                }
                .navigationBarTitle("GitHub Users")
                .alert(
                    isPresented: $userViewModel.isError,
                    content: {
                        Alert(
                            title: Text("Error"),
                            message: Text(userViewModel.errorMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                )
                
                if userViewModel.isLoading {
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(.circular)
                }
            }
        }
    }
    
    private func userListItem(gitUser: UserModel) -> some View  {
        HStack {
            AsyncImage(url: URL(string: gitUser.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.teal)
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(gitUser.login ?? "")
                    .font(.headline)
                
                Text(gitUser.url ?? "")
                    .font(.caption)
            }
            .padding(.leading, 40)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
