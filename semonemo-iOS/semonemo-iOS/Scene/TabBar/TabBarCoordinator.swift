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
        
        // TODO: 이미지 추가 및 상수 분리
        let groupListItem = UITabBarItem(title: "모임 리스트", image: nil, tag: 0)
        let generatingGroupItem = UITabBarItem(title: "모임 만들기", image: nil, tag: 1)
        let rewardItem = UITabBarItem(title: "리워드", image: nil, tag: 2)
        
        childCoordinators.append(groupListCoordinator)
        childCoordinators.append(generatingGroupCoordinator)
        childCoordinators.append(rewardCoordinator)
        
        let groupListViewController = groupListCoordinator.pushViewController()
        groupListViewController.tabBarItem = groupListItem
        let generatingGroupViewController = generatingGroupCoordinator.pushViewController()
        generatingGroupViewController.tabBarItem = generatingGroupItem
        let rewardViewController = rewardCoordinator.pushViewController()
        rewardViewController.tabBarItem = rewardItem
        
        tabBarController = TabBarController(pages: [groupListViewController, generatingGroupViewController, rewardViewController])
        guard let tabBarController = tabBarController else { return }

        navigationController?.viewControllers = [tabBarController]
    }
}
