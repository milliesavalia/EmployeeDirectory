@testable import Block_Employee_Directory
import Foundation
import Combine

class SuccessfulMockNetwork: NetworkProtocol {

    func employeeDirectoryPublisher() -> AnyPublisher<[Employee], Error> {
        Just([testEmployee, testEmployee2])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class FailureMockNetwork: NetworkProtocol {
    func employeeDirectoryPublisher() -> AnyPublisher<[Employee], Error> {
        Fail(error: NSError(domain: "FailureMockNetwork", code: 0, userInfo: nil))
            .eraseToAnyPublisher()
    }
}

let testEmployee =
    Employee(uuid: "1",
             fullName: "falynn",
             phoneNumber: "",
             emailAddress: "",
             biography: "",
             photoUrlSmall: nil,
             photoUrlLarge: nil,
             team: "",
             employeeType: .fullTime)

let testEmployee2 =
    Employee(uuid: "2",
             fullName: "belle",
             phoneNumber: "",
             emailAddress: "",
             biography: "",
             photoUrlSmall: nil,
             photoUrlLarge: nil,
             team: "",
             employeeType: .partTime)
