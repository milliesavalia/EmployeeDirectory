import UIKit

class ErrorView: UIView {
    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.text = NSLocalizedString("Employee Directory not available", comment: "error placeholder")
        return label
    }()
    
    func setup(with error: Error?) {
        if let error = error {
            errorLabel.text = "\(error)"
        }
        
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            errorLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            errorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            errorLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
