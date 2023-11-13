import UIKit

protocol HabitDetailsUpdateDelegate: AnyObject {
    func habitDetailUpdate(habit: Habit, at index: Int)
}

protocol HabitDetailsDeleteDelegate: AnyObject {
    func habitDetailDelete(at index: Int)
}

extension HabitDetailsViewController: HabitDetailsUpdateDelegate, HabitDetailsDeleteDelegate {
    func habitDetailUpdate(habit: Habit, at index: Int) {
        
        currentHabit = habit
        navigationItem.title = habit.name
        
        navigationController?.popToRootViewController(animated: true)
        habitDetailsUpdateDelegate?.habitDetailUpdate(habit: habit, at: index)
    }
    
    func habitDetailDelete(at index: Int) {
    
        navigationController?.popToRootViewController(animated: true)
        habitDetailsDeleteDelegate?.habitDetailDelete(at: index)
    }
}

class HabitDetailsViewController: UIViewController {
    
    weak var habitDetailsUpdateDelegate: HabitDetailsUpdateDelegate?
    
    weak var habitDetailsDeleteDelegate: HabitDetailsDeleteDelegate?
    
    private var index: Int
    private var currentHabit: Habit
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .customGrayLite
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(index: Int) {
        
        self.index = index
        self.currentHabit = HabitsStore.shared.habits[index]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetails()
        setupConstraints()
        setupNavigation()
    }
    
    private func setupDetails() {
        
        view.backgroundColor = .customGrayLite
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        tableView.register(
            HabitDetailsCollectionViewCell.self,
            forCellReuseIdentifier: "HabitDetailsCell"
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        
        navigationItem.title = currentHabit.name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .customPurple
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationItem.rightBarButtonItem = editButton

        navigationController?.toolbar.isHidden = true
    }
    
    @objc private func editHabit() {
        let habitViewController = HabitViewController(habit: currentHabit, index: index)
        
        habitViewController.habitUpdateDelegate = self  // Передача делегата
        habitViewController.habitDeleteDelegate = self  // Передача делегата
        
        let navigationHabitController = UINavigationController(rootViewController: habitViewController)
        navigationHabitController.modalPresentationStyle = .fullScreen
        self.present(navigationHabitController, animated: true)
    }
}


extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "HabitDetailsCell",
            for: indexPath
        ) as? HabitDetailsCollectionViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.setupCell(indexPath.row, index)
        
        return cell
    }
    

}
