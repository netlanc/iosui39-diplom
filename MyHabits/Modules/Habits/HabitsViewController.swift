import UIKit


protocol HabitsDelegate: AnyObject {
    func habitCreate()
    
    func reloadProgressBar()
}

extension HabitsViewController: HabitsDelegate, HabitDetailsDelegate {
    
    func habitCreate() {
        self.collectionView.reloadData()
    }
    
    func habitDetailDelete(at index: Int) {
        self.collectionView.deleteItems(at: [IndexPath(item: index, section: 1)])
        reloadProgressBar()
    }
    
    func reloadProgressBar() {
        self.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    func habitDetailUpdate(habit: Habit, at index: Int) {
//        self.collectionView.reloadData()
        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 1)])
    }
}

class HabitsViewController: UIViewController {

    
    private lazy var collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
//        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupHabbits()
        setupConstraints()
        
    }

    private func setupHabbits() {
        
        view.backgroundColor = .customGrayLite
        
        view.addSubview(collectionView)
        
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCell")
        collectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: "HabitsCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    private func setupNavigation() {
        
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newHabit))
        navigationItem.rightBarButtonItem?.tintColor = .customPurple
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }

    @objc private func newHabit() {
        let habitViewController = HabitViewController(habit: nil, index: nil)
        
        habitViewController.habitsDelegate = self
        
        let navigationHabitController = UINavigationController(rootViewController: habitViewController)
        navigationHabitController.modalPresentationStyle = .fullScreen
        self.present(navigationHabitController, animated: true)
    }

}


extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indexSection = indexPath.section
        let indexRow = indexPath.row
        
        if indexSection == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCell", for: indexPath) as! ProgressCollectionViewCell
            
            let percent = HabitsStore.shared.habits.count > 0 ? HabitsStore.shared.todayProgress:0.0
            
            cell.setupProgress(percent)
            
            return cell

        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCell", for: indexPath) as! HabitsCollectionViewCell
            cell.progressBarUpdateDelegete = self
            cell.setupHabit(HabitsStore.shared.habits[indexRow])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : HabitsStore.shared.habits.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section > 0 {
            let habitDetailsViewController = HabitDetailsViewController(index: indexPath.row)
            habitDetailsViewController.habitDetailsDelegate = self
//            habitDetailsViewController.habitDetailsDeleteDelegate = self
            navigationController?.pushViewController(habitDetailsViewController, animated: false)
            
        }
        collectionView.reloadData()
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.safeAreaLayoutGuide.layoutFrame.width - 32
        var height: Int = 60
        if (indexPath.section > 0) {
            height = 130
        }
        return CGSize(width: Int(width), height: height)
    }
}

