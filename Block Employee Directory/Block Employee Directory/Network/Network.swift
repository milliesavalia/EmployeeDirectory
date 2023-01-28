import Foundation
import Combine
import UIKit.UIImage

protocol NetworkProtocol {
    func employeeDirectoryPublisher() -> AnyPublisher<[Employee], Error>
}

final class Network: NetworkProtocol {
    let service: Service
    let endpoint: Endpoint
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return URLSession(configuration: configuration)
    }()
    
    init(service: Service = .init(), endpoint: Endpoint = .directory) {
        self.service = service
        self.endpoint = endpoint
    }
    
    func employeeDirectoryPublisher() -> AnyPublisher<[Employee], Error> {
        return URLSession.shared
            .dataTaskPublisher(for: service.url(endpoint: endpoint))
            .map(\.data)
            .decode(type: Directory.self, decoder: JSONDecoder(keyDecodingStrategy: .convertFromSnakeCase))
            .map(\.employees)
            .eraseToAnyPublisher()
    }
}

enum Endpoint: String {
    case directory = "employees"
    case directoryMalformed = "employees_malformed"
    case directoryEmpty = "employees_empty"
}

struct Service {
    func url(endpoint: Endpoint) -> URL {
        let urlString = "https://s3.amazonaws.com/sq-mobile-interview/" + endpoint.rawValue + ".json"
        
        let url = URL(string: urlString)
        return url!
    }
}

private extension JSONDecoder {
    convenience init(keyDecodingStrategy: KeyDecodingStrategy = .useDefaultKeys) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
