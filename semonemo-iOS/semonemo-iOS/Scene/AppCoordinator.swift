import UIKit

final class AppCoordinator: CoordinatorDescribing {
    // MARK: - Properties
    weak var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorDescribing]()
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        showHomeTabBarViewController()
    }
    
    private func showHomeTabBarViewController() {
        guard let navigationController = navigationController else { return }
        let homeTabBarCoordinator = HomeTabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(homeTabBarCoordinator)
        homeTabBarCoordinator.start()
    }
}
