//
//  KeyChainService.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import Security


protocol KeychainServiceProtocol {
    func add(query: [String: Any]) throws
    func update(query: [String: Any], attributes: [String: Any]) throws
    func delete(query: [String: Any]) throws
    func copyMatching(query: [String: Any]) throws -> Data?
}

// Default KeychainService implementation
class KeychainService: KeychainServiceProtocol {
    func add(query: [String: Any]) throws {
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.addFailed(status) }
    }
    
    func update(query: [String: Any], attributes: [String: Any]) throws {
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.updateFailed(status) }
    }
    
    func delete(query: [String: Any]) throws {
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.deleteFailed(status) }
    }
    
    func copyMatching(query: [String: Any]) throws -> Data? {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.copyMatchingFailed(status) }
        guard status == errSecSuccess else { throw KeychainError.copyMatchingFailed(status) }
        guard let data = item as? Data else { throw KeychainError.unexpectedDataFormat }
        return data
    }
}

// Keychain error enumeration
enum KeychainError: Error {
    case addFailed(OSStatus)
    case updateFailed(OSStatus)
    case deleteFailed(OSStatus)
    case copyMatchingFailed(OSStatus)
    case unexpectedDataFormat
    case invalidTokenConversion
}
