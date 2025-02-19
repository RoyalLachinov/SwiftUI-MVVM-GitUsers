//
//  UserViewModel.swift
//  await)
//
//  Created by Royal Lachinov on 2025-02-16.
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {

    @Published var userList: [UserModel]?
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchUser() async {
        isLoading = true
        do {
            let userList = try await WebService.getUsersData()
            self.userList = userList
            isLoading = false
        } catch(let error) {
            isLoading = false
            isError = true
            errorMessage = error.localizedDescription
        }
    }
}
