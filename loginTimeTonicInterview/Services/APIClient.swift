//
//  APIClient.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation
import Combine

protocol TimetonicAPIServiceProtocol {
    func createAppKey() -> AnyPublisher<AppkeyResponse, NetworkError>
    func createOauthKey(login: String, pwd: String, appkey: String) -> AnyPublisher<OauthkeyResponse, NetworkError>
    func createSesskey(o_u: String, oauthkey: String, restrictions: String) -> AnyPublisher<SesskeyResponse, NetworkError>
    func getAllBooks() -> AnyPublisher<BookModel.BookInfo, NetworkError>
}



class TimetonicAPIService: TimetonicAPIServiceProtocol {
    static let baseUrl = "https://timetonic.com/live/api.php"
    
    // Endpoints
    static let createAppKey = "/?req=createAppkey"
    static let createOauthkey = "/?req=createOauthkey"
    static let createSesskey = "/?req=createSesskey"
    static let version = "?version=1.47"
    static let getAllBooks = "&req=getAllBooks"
    static let shared = TimetonicAPIService() // Singleton
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getAllBooks() -> AnyPublisher<BookModel.BookInfo, NetworkError> {
        let tokenReader = TokenReader(keychainService: KeychainService())
        do {
            let sessk = try tokenReader.retrieveToken(service: TimetonicAPIService.baseUrl, account: "Sessk")!
            let ou = try tokenReader.retrieveToken(service: TimetonicAPIService.baseUrl, account: "o_u")!
            
            guard let url = URL(string: "\(TimetonicAPIService.baseUrl)\(TimetonicAPIService.version)\(String(describing: getAllBooks))&u_c=\(ou)&o_u=\(ou)&sesskey=\(sessk)") else {
                return Fail(error: .invalidResponse).eraseToAnyPublisher()
            }
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .mapError { NetworkError.networkError($0) }
                .flatMap { data, response -> AnyPublisher<Data, NetworkError> in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        return Fail(error: .invalidResponse).eraseToAnyPublisher()
                    }
                    return Just(data)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                }
                .decode(type: BookModel.BookInfo.self, decoder: JSONDecoder())
                .mapError { error in
                    if let decodingError = error as? DecodingError {
                        print("Decoding error: \(decodingError)")
                    }
                    return error is DecodingError ? NetworkError.decodingError : NetworkError.networkError(error)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: .networkError(error)).eraseToAnyPublisher()
        }
    }
    
    func createAppKey() -> AnyPublisher<AppkeyResponse, NetworkError> {
        // Construir la URL con los parámetros adecuados
        guard var components = URLComponents(string: "\(TimetonicAPIService.baseUrl)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        components.queryItems = [
            URLQueryItem(name: "req", value: "createAppkey"),
            URLQueryItem(name: "appname", value: "api")
        ]
        
        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        // Configurar la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Realizar la tarea de red
        return session.dataTaskPublisher(for: request)
            .mapError { NetworkError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, NetworkError> in
                // Validar la respuesta
                guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                return Just(data)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
            // Decodificar la respuesta
            .decode(type: AppkeyResponse.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingError }
            .eraseToAnyPublisher()
    }

    
    /// Create an OauthKey
    func createOauthKey(login: String, pwd: String, appkey: String) -> AnyPublisher<OauthkeyResponse, NetworkError> {
        guard let url = URL(string: "\(TimetonicAPIService.baseUrl)\(TimetonicAPIService.createOauthkey)&login=\(login)&pwd=\(pwd)&appkey=\(appkey)") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: request)
            .mapError { NetworkError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, NetworkError> in
                // Validate the response
                guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) else {
                    return Fail(error: .invalidResponse).eraseToAnyPublisher()
                }
                return Just(data)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
        // Decode the response
            .decode(type: OauthkeyResponse.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingError }
            .eraseToAnyPublisher()
    }
    
    /// Create an Sesskey
    func createSesskey(o_u: String, oauthkey: String, restrictions: String) -> AnyPublisher<SesskeyResponse, NetworkError> {
        guard let url = URL(string: "\(TimetonicAPIService.baseUrl)\(createSesskey)&o_u=\(o_u)&oauthkey=\(oauthkey)&restrictions=") else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        // Configure the request
        let request = URLRequest(url: url)
        
        return session.dataTaskPublisher(for: request)
            .mapError { NetworkError.networkError($0) }
            .flatMap { data, response -> AnyPublisher<Data, NetworkError> in
                guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) else {
                    return Fail(error: .invalidResponse).eraseToAnyPublisher()
                }
                return Just(data)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
        // Decode the response
            .decode(type: SesskeyResponse.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingError }
            .eraseToAnyPublisher()
    }
    
   
    func authenticate(email: String, password: String) -> AnyPublisher<String, Error> {
        return self.createAppKey()
            .flatMap { appKeyResponse in
                self.createOauthKey(login: email, pwd: password, appkey: appKeyResponse.appkey ?? "")
            }
            .flatMap { oauthKeyResponse in
                self.createSesskey(o_u: oauthKeyResponse.o_u, oauthkey: oauthKeyResponse.oauthkey ?? "", restrictions: "")
            }
            .tryMap { sessKeyResponse in
                guard let sesskey = sessKeyResponse.sesskey else {
                    throw NetworkError.invalidResponse
                }
                return sesskey
            }
            .eraseToAnyPublisher()
    }
    
    //    func authenticate(email: String, password: String) -> AnyPublisher<String, Error> {
    //        return self.createAppKey()
    //            .flatMap { appKeyResponse in
    //                self.createOauthKey(login: email, pwd: password, appkey: appKeyResponse.appkey ?? "")
    //            }
    //            .flatMap { oauthKeyResponse in
    //                self.createSesskey(o_u: oauthKeyResponse.o_u, oauthkey: oauthKeyResponse.oauthkey ?? "", restrictions: "")
    //            }
    //            .tryMap { sessKeyResponse in
    //                guard let sesskey = sessKeyResponse.sesskey else {
    //                    throw NetworkError.invalidResponse
    //                }
    //                return sesskey
    //            }
    //            .eraseToAnyPublisher()
    //    }
    
    var cancellables = Set<AnyCancellable>()
}


enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError
    case invalidRequest
}
