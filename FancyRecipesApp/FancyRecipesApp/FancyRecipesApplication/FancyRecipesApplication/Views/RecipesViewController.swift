import UIKit

class RecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let category: String
    let tableView = UITableView()
    var recipes: [Recipe] = []
    let refreshControl = UIRefreshControl()
    var recipesByCategory: [String: [Recipe]] = [:]

    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
        title = category
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecipeCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        loadRecipes()
    }

    func loadRecipes() {
        switch category {
        case "Первые блюда":
            recipes = [
                Recipe(title: "Борщ", ingredients: ["Свекла", "Капуста", "Картофель", "Морковь", "Лук", "Мясо"], steps: ["Порезать овощи", "Приготовить бульон", "Добавить овощи в бульон", "Варить до готовности"], category: "Первые блюда"),
                Recipe(title: "Щи", ingredients: ["Капуста", "Картофель", "Морковь", "Лук", "Мясо"], steps: ["Нарезать овощи", "Приготовить бульон", "Добавить овощи в бульон", "Варить до готовности"], category: "Первые блюда")
            ]
        case "Горячие основные блюда":
            recipes = [
                Recipe(title: "Бефстроганов", ingredients: ["Говядина", "Лук", "Грибы", "Сметана", "Мука", "Масло"], steps: ["Обжарить мясо", "Добавить лук и грибы", "Поджарить", "Добавить сметану", "Закипятить"], category: "Горячие основные блюда"),
                Recipe(title: "Куриные котлеты", ingredients: ["Филе куриное", "Лук", "Соль", "Перец", "Мука", "Яйцо", "Масло"], steps: ["Нарезать курицу", "Добавить лук, соль и перец", "Сформировать котлеты", "Обвалять в муке и яйце", "Обжарить на сковороде"], category: "Горячие основные блюда")
            ]
        case "Салаты":
            recipes = [
                Recipe(title: "Греческий салат", ingredients: ["Огурцы", "Помидоры", "Перец", "Оливки", "Сыр фета", "Оливковое масло", "Лимонный сок", "Соль", "Перец"], steps: ["Нарезать овощи", "Добавить оливки и сыр", "Полить маслом и соком", "Посолить и поперчить"], category: "Салаты"),
                Recipe(title: "Цезарь", ingredients: ["Салат романо", "Куриное филе", "Хлеб", "Сыр пармезан", "Яйца", "Чеснок", "Майонез", "Соль", "Перец"], steps: ["Подготовить куриное филе", "Приготовить заправку", "Обжарить хлебные кубики"], category: "Салаты")
            ]
        case "Десерты":
            recipes = [
                Recipe(title: "Тирамису", ingredients: ["Сыр маскарпоне", "Яйца", "Сахар", "Кофе", "Ликер Амаретто", "Савоярди", "Какао"], steps: ["Смешать сыр, яйца и сахар", "Замачивать савоярди в кофе с ликером", "Слагать слои"], category: "Десерты"),
                Recipe(title: "Шоколадный фондан", ingredients: ["Темный шоколад", "Масло", "Сахар", "Мука", "Яйца", "Соль"], steps: ["Растопить шоколад и масло", "Добавить сахар и яйца", "Постепенно вводить муку"], category: "Десерты")
            ]
        case "Закуски":
            recipes = [
                Recipe(title: "Гуакамоле", ingredients: ["Авокадо", "Лук", "Помидор", "Лайм", "Соль", "Перец", "Кинза"], steps: ["Размять авокадо", "Добавить нарезанные лук и помидор", "Посолить, поперчить", "Добавить сок лайма и кинзу"], category: "Закуски"),
                Recipe(title: "Баклажанная икра", ingredients: ["Баклажаны", "Помидоры", "Лук репчатый", "Чеснок", "Перец сладкий", "Морковь", "Петрушка", "Оливковое масло", "Уксус", "Соль", "Перец"], steps: ["Баклажаны запечь в духовке", "Обжарить лук и чеснок", "Добавить остальные овощи", "Пассировать все вместе", "Подавать охлажденной"], category: "Закуски")
            ]
        case "Другое":
            recipes = [
                Recipe(title: "Маринованные огурцы", ingredients: ["Огурцы", "Уксус 9%", "Вода", "Сахар", "Соль", "Перец горошком", "Лавровый лист", "Чеснок", "Укроп"], steps: ["Нарезать огурцы", "Приготовить маринад", "Добавить огурцы в маринад", "Охладить и хранить в холодильнике"], category: "Другое")
            ]
        default:
            break
        }
        tableView.reloadData()
    }
    private func setupNavigationBar() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
        }

        @objc private func addRecipe() {
            let addRecipeVC = AddRecipeViewController()
            navigationController?.pushViewController(addRecipeVC, animated: true)
        }

        @objc private func refreshRecipes() {
            // Обновление данных, если необходимо
            tableView.reloadData()
            refreshControl.endRefreshing()
        }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = recipes[indexPath.row]
        let recipeDetailViewController = RecipeDetailViewController(recipe: recipe)
        navigationController?.pushViewController(recipeDetailViewController, animated: true)
    }
    func fetchRecipes() {
        recipes = recipesByCategory[category] ?? []
        tableView.reloadData()
    }
}

