import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

enum GroupListViewConstraint {
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
    static let minimumLineSpacing: CGFloat = 15
    static let minimumInteritemSpacing: CGFloat = 10
    static let inset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    static let numberOfCells: CGFloat = 8
}

final class GroupListViewController: UIViewController, UIScrollViewDelegate {
    private let viewModel = GroupListViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = configureFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        
        viewModel.input.onViewDidLoad.accept(())
    }
    
    private func bind() {
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        viewModel.output.sectionsRelay
            .bind(to: collectionView.rx.items(dataSource: createDatasource()))
            .disposed(by: bag)
        
    }
    
    private func setUp() {
        collectionView.register(GroupListCell.self, forCellWithReuseIdentifier: GroupListCell.id)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = GroupListViewConstraint.inset
        flowLayout.minimumLineSpacing = GroupListViewConstraint.minimumLineSpacing
        flowLayout.minimumInteritemSpacing = GroupListViewConstraint.minimumInteritemSpacing
        flowLayout.itemSize.width = GroupListViewConstraint.deviceWidth - GroupListViewConstraint.inset.left - GroupListViewConstraint.inset.right
        flowLayout.itemSize.height = (GroupListViewConstraint.deviceHeight - GroupListViewConstraint.inset.top - GroupListViewConstraint.inset.bottom) / GroupListViewConstraint.numberOfCells
        return flowLayout
    }
    
    private func createDatasource() -> RxCollectionViewSectionedReloadDataSource<SectionModel<ItemSection, GroupInfo>> {
        return .init { datasource, collectionView, indexPath, item in
            let section = datasource.sectionModels[indexPath.section].identity
            
            switch section {
            case .groupInfo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupListCell.id, for: indexPath) as? GroupListCell else {
                    return UICollectionViewCell()
                }
                
                cell.setUpLabel(group: item)
                
                return cell
            }
        }
    }
}
