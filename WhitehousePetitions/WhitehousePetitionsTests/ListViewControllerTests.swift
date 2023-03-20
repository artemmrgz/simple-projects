//
//  ListViewControllerTests.swift
//  WhitehousePetitionsTests
//
//  Created by Artem Marhaza on 20/03/2023.
//

import Foundation
import XCTest

@testable import WhitehousePetitions

class ListViewControllerTests: XCTestCase {
    var vc: ListViewController!
    var mockManager: MockManager!
    
    class MockManager: PetitionsMenageable {
        var petitions: Petitions?
        var error: NetworkError?
        
        func fetchPetitions(url: String, completion: @escaping (Result<WhitehousePetitions.Petitions, WhitehousePetitions.NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
            } else {
                let petitionList = [Petition(title: "title", body: "body", signatureCount: 1)]
                let petitions = Petitions(results: petitionList)
                completion(.success(petitions))
            }
        }
    }
    
    override func setUp() {
        vc = ListViewController(urlString: "https://some/url", titleName: "Title")
        
        mockManager = MockManager()
        vc.petitionsManager = mockManager
    }
    
    func testGetTitleAndMessageForServerError() throws {
        let result = vc.getTitleAndMessage(for: NetworkError.serverError)
        
        XCTAssertEqual(result.0, "Server Error")
        XCTAssertEqual(result.1, "Ensure you are connected to the internet. Please try again.")
    }
    
    func testGetTitleAndMessageForDecodingError() throws {
        let result = vc.getTitleAndMessage(for: NetworkError.decodingError)
        
        XCTAssertEqual(result.0, "Error")
        XCTAssertEqual(result.1, "We could not process your request. Please try again.")
    }
}
