import UIKit

protocol HabitDetailsDelegate: AnyObject {
    func habitDetailUpdate(habit: Habit, at index: Int)
    
    func habitDetailDelete(at index: Int)
}

extension HabitDetailsViewController: HabitDetailsDelegate {
    func habitDetailUpdate(habit: Habit, at index: Int) {
        
        currentHabit = habit
        navigationItem.title = habit.name
        
        navigationController?.popToRootViewController(animated: true)
        habitDetailsDelegate?.habitDetailUpdate(habit: habit, at: index)
    }
    
    func habitDetailDelete(at index: Int) {
    
        navigationController?.popToRootViewController(animated: true)
        habitDetailsDelegate?.habitDetailDelete(at: index)
    }
}

class HabitDetailsViewController: UIViewController {
    
    weak var habitDetailsDelegate: HabitDetailsDelegate?
    
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
        
//        habitViewController.habitsDelegate = self  // Передача делегата
        habitViewController.habitDetailsDelegate = self  // Передача делегата
        
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
