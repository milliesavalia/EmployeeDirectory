@testable import Block_Employee_Directory
import XCTest
import Combine

class NetworkSpec: XCTestCase {
    var cancellable: AnyCancellable?
    
    func testEmployeeDirectoryLoadSuccessful() {
        let expectation = self.expectation(description: "Receive employees and complete")
        expectation.expectedFulfillmentCount = 2
        
        cancellable = SuccessfulMockNetwork().employeeDirectoryPublisher()
            .sink(receiveCompletion: { (completion) in
                if case .finished = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { (employees) in
                if employees.count == 2 {
                    expectation.fulfill()
                }
            })
        waitForExpectations(timeout: 0)
    }
    
    func testEmployeeDirectoryLoadFailure() {
        let expectation = self.expectation(description: "Receive no employees and complete with an error")
        expectation.isInverted = true
        
        cancellable = FailureMockNetwork().employeeDirectoryPublisher()
            .sink(receiveCompletion: { (completion) in
                if case .finished = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { (employees) in
                expectation.fulfill()
            })
        waitForExpectations(timeout: 0)
    }
}
