import UIKit

final class GroupListViewController: UIViewController {
    // MARK: - Initializers
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        configureTabBar()
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    private func configureTabBar() {
        self.tabBarItem.image = UIImage(named: "icon_list")
        self.tabBarItem.selectedImage = UIImage(named: "icon_list_selected")
    }
}
