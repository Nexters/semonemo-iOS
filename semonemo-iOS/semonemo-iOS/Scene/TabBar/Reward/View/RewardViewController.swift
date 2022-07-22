import UIKit

final class RewardViewController: UIViewController {
    // MARK: - Initializers
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        configureTabBar()
    }
    
    // MARK: - LifecycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    private func configureTabBar() {
        self.tabBarItem.image = UIImage(named: "icon_reward")
        self.tabBarItem.selectedImage = UIImage(named: "icon_reward_selected")
    }
}
