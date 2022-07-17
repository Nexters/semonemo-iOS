import UIKit

final class RewardCoordinator: CoordinatorDescribing {
    // MARK: - Properties
    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorDescribing]()
    
    // MARK: - Methods
    func start() {
    }
    
    func pushViewController() -> UINavigationController {
        let rewardViewController = RewardViewController()
        rewardViewController.view.backgroundColor = .green
        navigationController = UINavigationController(rootViewController: rewardViewController)
        
        guard let navigationController = navigationController else { return UINavigationController() }
        
        return navigationController
    }
}
