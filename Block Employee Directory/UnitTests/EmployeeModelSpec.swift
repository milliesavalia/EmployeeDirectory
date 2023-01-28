@testable import Block_Employee_Directory
import XCTest

class EmployeeModelSpec: XCTestCase {
    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    
    func testValidEmployee() throws {
        let employee = try decoder.decode(Employee.self, from: validEmployeeResponse)
        XCTAssertEqual(employee.uuid, "0d8fcc12-4d0c-425c-8355-390b312b909c")
        XCTAssertEqual(employee.fullName, "John Doe")
        XCTAssertEqual(employee.phoneNumber, "18009991989")
        XCTAssertEqual(employee.emailAddress, "jdoe@square.com")
        XCTAssertEqual(employee.biography, "Engineer who loves the outdoors.")
        XCTAssertEqual(employee.photoUrlSmall, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")
        XCTAssertEqual(employee.photoUrlLarge, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")
        XCTAssertEqual(employee.team, "Restaurants")
        XCTAssertEqual(employee.employeeType, .fullTime)
    }
    
    func testInvalidEmployee() throws {
        XCTAssertThrowsError(try decoder.decode(Employee.self, from: invalidEmployeeResponse))
    }
}
