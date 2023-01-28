import Foundation

// MARK: - Directory
struct Directory: Codable {
    let employees: [Employee]
    
    enum CodingKeys: String, CodingKey {
        case employees
    }
}
