//
//  Petition.swift
//  WhitehousePetitions
//
//  Created by Artem Marhaza on 18/03/2023.
//

import UIKit

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}

enum NetworkError: Error {
    case serverError
    case decodingError
}

protocol PetitionsMenageable: AnyObject {
    func fetchPetitions(url: String, completion: @escaping (Result<Petitions, NetworkError>) -> Void)
}

class PetitionsManager: PetitionsMenageable {
    func fetchPetitions(url: String, completion: @escaping (Result<Petitions, NetworkError>) -> Void) {
        print("1")
        guard let urlString = URL(string: url) else { return }
        print("2")
        
        URLSession.shared.dataTask(with: urlString) { data, response, error in
            print("before async")
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("falure")
                    completion(.failure(.serverError))
                    return
                }
                print("after falure")
                
                do {
                    print("before try")
                    let petitions = try JSONDecoder().decode(Petitions.self, from: data)
                    print("success")
                    completion(.success(petitions))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
