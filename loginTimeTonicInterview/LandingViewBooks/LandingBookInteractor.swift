//
//  LandingBookInteractor.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation


class LandingBookInteractor {
    func getListOfBooks(completion: @escaping (Result<[BookModel.BookInfo], Error>) -> Void) {
        let o_u = "demo"
        let u_c = "demo"
        let sesskey = "gYES-yRmr-eSuT-EKP3-cx1c-8SDu-YfDl"
        
        // Prepare parameters
        let parameters = [
            "version": "1.47",
            "req": "getAllBooks",
            "o_u": o_u,
            "u_c": u_c,
            "sesskey": sesskey
        ]
        
        // Create URL and URLRequest
        guard let url = URL(string: "https://timetonic.com/live/api.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Encode parameters
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completion(.failure(NSError(domain: "Parameter Encoding Error", code: 0, userInfo: nil)))
            return
        }
        request.httpBody = httpBody
        
        // Perform data task
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            // Parse JSON response
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(BookModel.ListBookResponse.self, from: data)
                if response.status == "ok" {
                    completion(.success(response.allBooks))
                } else if let errorMsg = response.errorMsg {
                    completion(.failure(NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMsg])))
                } else {
                    completion(.failure(NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
