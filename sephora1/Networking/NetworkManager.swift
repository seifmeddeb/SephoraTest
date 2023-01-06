//
//  NetworkManager.swift
//  sephora1
//
//  Created by Seif Meddeb on 04/01/2023.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func getProductsList(completion: @escaping ([Product], Error?) -> Void)
}

class NetworkManager: NetworkProtocol {
    
    let url = URL(string: "https://sephoraios.github.io/items.json")!
    
    private var cancellable: AnyCancellable?
    
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }

    func getProductsList(completion: @escaping ([Product], Error?) -> Void) {
        cancellable = session.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    return Data()
                }
                return element.data
            }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] sinkCompletion in
                switch sinkCompletion {
                case .failure(let error):
                    guard let error = (error as? URLError),
                          error.code == .timedOut,
                          let urlCache = self?.session.configuration.urlCache,
                          let url = self?.url,
                          let cachedResponseData = urlCache.cachedResponse(for: URLRequest(url: url))?.data
                    else {
                        completion([], error)
                        return
                    }
                    do {
                        let products = try JSONDecoder().decode([Product].self, from: cachedResponseData)
                        completion(products, nil)
                    } catch {
                        completion([], error)
                    }
                case .finished:
                    debugPrint("🌐 Publisher is finished")
                }
            }, receiveValue: { products in
                completion(products, nil)
            })
    }

}
