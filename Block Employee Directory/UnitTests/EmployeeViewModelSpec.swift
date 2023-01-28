@testable import Block_Employee_Directory
import XCTest
import Combine

class DirectoryViewModelTests: XCTestCase {
    var cancellable: AnyCancellable?

    func testValidResponseStoresEmployees() {
        let viewModel = EmployeeDirectoryViewModel(network: SuccessfulMockNetwork())
        let expectation = expectation(description: "employees_loaded")
        cancellable = viewModel
            .fetch()
            .sink { state in
                if case let .success(employees) = state {
                    XCTAssertFalse(employees.isEmpty)
                    XCTAssertEqual(employees.count, 2)
                    
                    // checks sorting by fullname
                    XCTAssertEqual(employees[0].fullName, "belle")
                    XCTAssertEqual(employees[1].fullName, "falynn")
                    
                    expectation.fulfill()
                }
            }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(viewModel.employees)
    }
}
