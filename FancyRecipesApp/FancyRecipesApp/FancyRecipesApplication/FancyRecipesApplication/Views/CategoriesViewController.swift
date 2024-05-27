import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewRecipeDelegate {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let categories = ["Первые блюда", "Горячие основные блюда", "Салаты", "Десерты", "Закуски", "Другое"]
    let categoryImages: [UIImage?] = [
        UIImage(named: "first_dishes"),
        UIImage(named: "hot_main_dishes"),
        UIImage(named: "salads"),
        UIImage(named: "desserts"),
        UIImage(named: "snacks"),
        UIImage(named: "other")
    ]
    var recipesByCategory: [String: [Recipe]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Категории"
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let bottomBar = UIView()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = UIColor(red: 0.94, green: 0.35, blue: 0.42, alpha: 1.0)
        view.addSubview(bottomBar)
        
        let separatorLine = UIView()
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = .white
        bottomBar.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let categoriesButton = UIButton(type: .system)
        categoriesButton.setTitle("Категории", for: .normal)
        categoriesButton.setTitleColor(.white, for: .normal)
        categoriesButton.addTarget(self, action: #selector(categoriesButtonTapped), for: .touchUpInside)
        categoriesButton.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.addSubview(categoriesButton)
        
        let addRecipeButton = UIButton(type: .system)
        addRecipeButton.setTitle("Добавить рецепт", for: .normal)
        addRecipeButton.setTitleColor(.white, for: .normal)
        addRecipeButton.addTarget(self, action: #selector(addRecipeButtonTapped), for: .touchUpInside)
        addRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.addSubview(addRecipeButton)
        
        NSLayoutConstraint.activate([
            categoriesButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 16),
            categoriesButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor),
            
            addRecipeButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -16),
            addRecipeButton.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func addRecipeButtonTapped() {
            let newRecipeVC = NewRecipeViewController()
            newRecipeVC.delegate = self
            navigationController?.pushViewController(newRecipeVC, animated: true)
        }
        
    func didSaveNewRecipe(_ recipe: Recipe) {
        if let categoryIndex = categories.firstIndex(of: recipe.category) {
            let category = categories[categoryIndex]
            recipesByCategory[category, default: []].append(recipe)
            
            if let recipesVC = navigationController?.viewControllers.compactMap({ $0 as? RecipesViewController }).first(where: { $0.category == category }) {
                recipesVC.recipes = recipesByCategory[category] ?? []
                recipesVC.tableView.reloadData()
            }
        }
    }



    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.configure(with: categories[indexPath.item], image: categoryImages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 8
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        let recipesVC = RecipesViewController(category: selectedCategory)
        navigationController?.pushViewController(recipesVC, animated: true)
    }
    
    @objc func categoriesButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc func addButtonTapped() {
        let newRecipeVC = NewRecipeViewController()
        newRecipeVC.delegate = self
        navigationController?.pushViewController(newRecipeVC, animated: true)
    }


}

class RecipeListViewController: UIViewController {
    let category: String
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = category
    }
}

class AddRecipeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Добавить рецепт"
    }
}
