import UIKit

final class GeneratingGroupCoordinator: CoordinatorDescribing {
    // MARK: - Properties

    var navigationController: UINavigationController?
    var childCoordinators = [CoordinatorDescribing]()
    
    // MARK: - Methods

    func start() {}
    
    func pushViewController() -> UINavigationController {
        let generatingGroupViewController = GeneratingGroupViewController()
        navigationController = UINavigationController(rootViewController: generatingGroupViewController)
        navigationController?.navigationBar.isHidden = true
        
        guard let navigationController = navigationController else { return UINavigationController() }
        
        return navigationController
    }
}
