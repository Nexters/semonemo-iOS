import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    private var pages: [UINavigationController]?
    
    // MARK: - Initializers
    init(pages: [UINavigationController]) {
        super.init(nibName: nil, bundle: nil)
        self.pages = pages
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.tintColor = Color.tabBarTintColor
        tabBar.unselectedItemTintColor = Color.tabBarUnselectedTintColor
        viewControllers = pages
    }
}

extension TabBarController {
    private enum Color {
        static let tabBarTintColor: UIColor = .black
        static let tabBarUnselectedTintColor: UIColor = .systemGray
    }
}
