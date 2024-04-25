//
//  TokenUpdater.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 15/04/24.
//

import Foundation
import Security

class TokenUpdater {
    private let keychainService: KeychainService

    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }
    
    func updateToken(_ token: String, service: String, account: String) throws {
        guard let data = token.data(using: .utf8) else { throw KeychainError.invalidTokenConversion }

        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account]
        as [String : Any]
        
        let attributes = [kSecValueData as String: data]

        try keychainService.update(query: query, attributes: attributes)
    }
}
