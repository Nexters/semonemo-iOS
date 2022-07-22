import UIKit

final class GeneratingGroupViewController: UIViewController {
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
        self.tabBarItem.image = UIImage(named: "icon_add")
        self.tabBarItem.selectedImage = UIImage(named: "icon_add_selected")
    }
}
