import SDWebImage
import UIKit

class EmployeeTableViewCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()

    lazy var teamLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
        
    lazy var employeeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
        
    func setup(with employee: Employee) {
        nameLabel.text = employee.fullName
        teamLabel.text = employee.team
        
        if let smallImageURL = employee.photoUrlSmall,
           let imageURL = URL(string: smallImageURL) {
            employeeImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "noImage"))
        }
        
        commonSetup()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        employeeImageView.image = nil
        nameLabel.text = ""
        teamLabel.text = ""
    }
    
    private func commonSetup() {
        contentView.addSubview(employeeImageView)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(teamLabel)
        
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: 70),
            employeeImageView.widthAnchor.constraint(equalToConstant: 70),
            employeeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            employeeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 108),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
