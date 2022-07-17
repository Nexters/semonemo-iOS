import UIKit

final class GroupListCoordinator: CoordinatorDescribing {
    // MARK: - Properties
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorDescribing]()

    // MARK: - Methods
    func start() {
    }
    
    func pushViewController() -> UINavigationController {
        let groupListViewController = GroupListViewController()
        groupListViewController.view.backgroundColor = .red
        navigationController = UINavigationController(rootViewController: groupListViewController)
        
        guard let navigationController = navigationController else { return UINavigationController() }
        
        return navigationController
    }
}
