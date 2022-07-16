import UIKit

final class HomeTabBarCoordinator: CoordinatorDescribing {
    // MARK: - Properties
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorDescribing]()
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        let homeTabBarViewController = HomeTabBarViewController()
        navigationController?.pushViewController(homeTabBarViewController, animated: true)
    }
}
