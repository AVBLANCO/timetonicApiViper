//
//  LoginPageInteractor.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

protocol LoginPageInteractorInput {
    func login(email: String, password: String)
}

protocol LoginPageInteractorOutput {
    func loginSuccess(oauthKey: String)
    func loginFailure(error: Error)
}

protocol ILoginPageInteractor: AnyObject {
    var parameters: [String: Any]? { get set }
    func login(email: String, password: String)
}

class LoginPageInteractor: ILoginPageInteractor {
    var presenter: ILoginPagePresenter?
    var manager: ILoginPageManager?
    var parameters: [String: Any]?
    var output: LoginPageInteractorOutput?
    
    func login(email: String, password: String) {
        TimetonicAPIService.shared.authenticate(email: email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.output?.loginFailure(error: error)
                }
            }, receiveValue: { sesskey in
                self.output?.loginSuccess(oauthKey: sesskey)
            })
            .store(in: &TimetonicAPIService.shared.cancellables)
    }
}
//
//class LoginPageInteractor: ILoginPageInteractor {
//    
//    // Propiedades para almacenar appkey, oauthkey y sesskey
//    private var appkey: String?
//    private var oauthkey: String?
//    private var sesskey: String?
//    
//    var presenter: ILoginPagePresenter?
//    var manager: ILoginPageManager?
//    var parameters: [String: Any]?
//    
//    var output: LoginPageInteractorOutput?
//    
//    func login(email: String, password: String) {
//        authenticateUser(email: email, password: password)
//    }
//    
//    private func getAppkey(completion: @escaping (String?) -> Void) {
//        let urlString = "https://timetonic.com/live/api.php"
//        let parameters = [
//            "version": "1.47",
//            "req": "createAppkey",
//            "appname": "android"
//        ]
//        
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
//        } catch {
//            print("Error serializing parameters: \(error)")
//            completion(nil)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error de red: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//                return
//            }
//            
//            print("Response data: \(String(data: data, encoding: .utf8) ?? "")") // Nueva impresión
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let appkeyResponse = try decoder.decode(AppkeyResponse.self, from: data)
//                
//                guard appkeyResponse.status == "ok", let appkey = appkeyResponse.appkey else {
//                    print("Error: Respuesta del servidor no válida")
//                    completion(nil)
//                    return
//                }
//                
//                completion(appkey)
//            } catch {
//                print("Error decoding response: \(error)")
//                completion(nil)
//            }
//        }.resume()
//    }
//
//    
//    
//    
//    //    private func getOauthkey(email: String, password: String) {
//    private func getOauthkey(email: String, password: String, appkey: String, completion: @escaping (String?) -> Void) {
//        let urlString = "https://timetonic.com/live/api.php"
//        let parameters = [
//            "version": "1.47",
//            "req": "createOauthkey",
//            "login": email,
//            "pwd": password,
//            "appkey": appkey
//        ]
//        
//        guard let url = URL(string: urlString),
//              let jsonData = try? JSONSerialization.data(withJSONObject: parameters),
//              let oauthkeyRequest = try? JSONDecoder().decode(OauthkeyRequest.self, from: jsonData) else {
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//            
//            do {
//                let oauthkeyResponse = try JSONDecoder().decode(OauthkeyResponse.self, from: data)
//                if oauthkeyResponse.status == "ok" {
//                    let oauthkey = oauthkeyResponse.oauthkey
//                    completion(oauthkey)
//                } else {
//                    print("Error obteniendo oauthkey: \(oauthkeyResponse.errorMsg ?? "Error desconocido")")
//                    completion(nil)
//                }
//            } catch {
//                print("Error decoding response: \(error)")
//                completion(nil)
//            }
//        }.resume()
//    }
//    
//    
//    //    private func getSesskey() {
//    private func getSesskey(oauthkey: String, completion: @escaping (String?) -> Void) {
//        let urlString = "https://timetonic.com/live/api.php"
//        let parameters = [
//            "version": "1.47",
//            "req": "createSesskey",
//            "o_u": "oauth_userid",
//            "u_c": "oauth_userid",
//            "oauthkey": oauthkey
//        ]
//        
//        guard let url = URL(string: urlString),
//              let jsonData = try? JSONSerialization.data(withJSONObject: parameters),
//              let sesskeyRequest = try? JSONDecoder().decode(SesskeyRequest.self, from: jsonData) else {
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//            
//            do {
//                let sesskeyResponse = try JSONDecoder().decode(SesskeyResponse.self, from: data)
//                if sesskeyResponse.status == "ok" {
//                    let sesskey = sesskeyResponse.sesskey
//                    print("Sesskey obtenido con éxito: \(sesskey)")
//                    completion(sesskey)
//                } else {
//                    print("Error obteniendo sesskey: \(sesskeyResponse.errorMsg ?? "Error desconocido")")
//                    completion(nil)
//                }
//            } catch {
//                print("Error decoding response: \(error)")
//                completion(nil)
//            }
//        }.resume()
//    }
//    
//    private func authenticateUser(email: String, password: String) {
//        getAppkey { appkey in
//            guard let appkey = appkey else {
//                return
//            }
//            
//            self.getOauthkey(email: email, password: password, appkey: appkey) { oauthkey in
//                guard let oauthkey = oauthkey else {
//                    return
//                }
//                
//                self.getSesskey(oauthkey: oauthkey) { sesskey in
//                    guard let sesskey = sesskey else {
//                        return
//                    }
//                    
//                    // Almacenar el sesskey obtenido
//                    self.sesskey = sesskey
//                    
//                    // Notificar al presentador sobre el éxito de la autenticación
//                    self.output?.loginSuccess(oauthKey: oauthkey)
//                }
//            }
//        }
//    }
//    
//    
//}
