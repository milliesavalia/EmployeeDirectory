import Foundation
import Combine

enum State {
    case success([Employee])
    case failure(Error)
}

class EmployeeDirectoryViewModel: ObservableObject {
    private let network: NetworkProtocol
    private var cancellable: AnyCancellable?
    var showError: Bool = false
    var error: Error?
    var employees: [Employee] = [Employee]()
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetch() -> AnyPublisher<State, Never> {
        let statePublisher = network.employeeDirectoryPublisher()
            .map { $0.sorted { x, y in x.fullName < y.fullName } }
            .map { State.success($0)}
            .catch { Just(State.failure($0)) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        cancellable = statePublisher.sink(receiveValue: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success(let employeeList):
                self.employees = employeeList
                if employeeList.isEmpty {
                    self.showError = true
                }
            case .failure(let error):
                self.showError = true
                self.error = error
            }
        })
        return statePublisher
    }
}
