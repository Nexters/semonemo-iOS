import UIKit

final class TabBarCoordinator: CoordinatorDescribing {
    // MARK: - Properties
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorDescribing]()
    
    private var tabBarController: TabBarController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let groupListViewController = GroupListViewController()
        navigationController?.pushViewController(groupListViewController, animated: true)
        
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let groupListCoordinator = GroupListCoordinator()
        let generatingGroupCoordinator = GeneratingGroupCoordinator()
        let rewardCoordinator = RewardCoordinator()

        childCoordinators.append(groupListCoordinator)
        childCoordinators.append(generatingGroupCoordinator)
        childCoordinators.append(rewardCoordinator)
        
        let groupListViewController = groupListCoordinator.pushViewController()
        let generatingGroupViewController = generatingGroupCoordinator.pushViewController()
        let rewardViewController = rewardCoordinator.pushViewController()
        
        tabBarController = TabBarController(pages: [groupListViewController, generatingGroupViewController, rewardViewController])
        guard let tabBarController = tabBarController else { return }
        configureTabBarAppearance(for: tabBarController)
        
        navigationController?.viewControllers = [tabBarController]
    }
    
    private func configureTabBarAppearance(for tabBarController: TabBarController) {
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.layer.cornerRadius = 20
        tabBarController.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBarController.tabBar.layer.applyShadow(direction: .top)
    }
}
