import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var infoTabNavigationController : UINavigationController {
        let tabController = UINavigationController(rootViewController: InfoViewController());
        tabController.title = "Информация"
        
        tabController.tabBarItem = UITabBarItem(
            title: "Информация",
            image: UIImage(systemName: "info.circle.fill"),
            tag: 1)
        
        tabController.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 12, weight: .regular)
            ],
        for: .normal)
        
        return tabController
    }
    
    var habitsTabNavigationControoller : UINavigationController {
        let tabController = UINavigationController(rootViewController: HabitsViewController());
        tabController.title = "Привычки"
        
        tabController.tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(systemName: "rectangle.grid.1x2.fill"),
            tag: 0)
        
        tabController.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 12, weight: .regular)
            ],
        for: .normal)
        
        return tabController
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.6906365752, green: 0, blue: 0.8297687173, alpha: 1)
        
        self.viewControllers = [
            habitsTabNavigationControoller,
            infoTabNavigationController
        ]
        self.selectedIndex = 0
    }
    
}
