//
//  TokenDelete.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 15/04/24.
//

import Foundation
import Security

class TokenDeleter {
    private let keychainService: KeychainService

    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }

    /// Delete a token to the keychain
    func deleteToken(service: String, account: String) throws {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account]
        as [String : Any]
        
        try keychainService.delete(query: query)
    }
}
