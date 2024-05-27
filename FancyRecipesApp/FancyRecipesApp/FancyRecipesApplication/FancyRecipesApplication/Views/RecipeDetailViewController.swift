import UIKit

class RecipeDetailViewController: UIViewController {

    let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
        title = recipe.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ингредиенты:\n" + recipe.ingredients.joined(separator: "\n")
        ingredientsLabel.numberOfLines = 0

        let stepsLabel = UILabel()
        stepsLabel.text = "Шаги:\n" + recipe.steps.joined(separator: "\n")
        stepsLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [ingredientsLabel, stepsLabel])
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

