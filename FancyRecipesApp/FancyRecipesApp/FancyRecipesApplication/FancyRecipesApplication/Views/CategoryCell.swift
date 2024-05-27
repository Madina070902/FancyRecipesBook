import UIKit

class CategoryCell: UITableViewCell {
    
    let categoryImageView = UIImageView()
    let categoryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        categoryImageView.contentMode = .scaleAspectFit
        contentView.addSubview(categoryImageView)
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            categoryImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 80), // Увеличение высоты изображения
            categoryImageView.widthAnchor.constraint(equalToConstant: 80) // Увеличение ширины изображения
        ])

        categoryLabel.font = .systemFont(ofSize: 18, weight: .medium) // Уменьшение размера шрифта
        categoryLabel.textAlignment = .center
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    func configure(with category: String, image: UIImage?) {
        categoryLabel.text = category
        categoryImageView.image = image ?? UIImage(named: "placeholder")
    }
}
