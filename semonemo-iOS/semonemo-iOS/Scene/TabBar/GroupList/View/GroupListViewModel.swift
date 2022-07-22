//
//  GroupListViewModel.swift
//  semonemo-iOS
//
//  Created by Ellen on 2022/07/22.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import Alamofire

protocol GroupListInputInterface {
    var onViewDidLoad: PublishRelay<Void> { get }
}

protocol GroupListOutputInterface {
    var sectionsRelay: Observable<[SectionModel<ItemSection, GroupInfo>]> { get }
}

protocol GroupListInterfaceable {
    var input: GroupListInputInterface { get }
    var output: GroupListOutputInterface { get }
}

enum ItemSection {
    case groupInfo
}

class GroupListViewModel: GroupListInterfaceable, GroupListInputInterface, GroupListOutputInterface {
    
    var groupInfo: [GroupInfo] = []
    private let bag = DisposeBag()
    
    // MARK: -  GroupListInterfaceable Properties
    var input: GroupListInputInterface { return self }
    var output: GroupListOutputInterface { return self }
    
    var onViewDidLoad: PublishRelay<Void> = .init()
    
    // MARK: - OutputProperties
    var sectionsRelay: Observable<[SectionModel<ItemSection, GroupInfo>]> {
        return sectionSubject.asObservable()
    }
    
    // MARK: - Private OutputProperties
    private let sectionSubject: PublishSubject<[SectionModel<ItemSection, GroupInfo>]> = .init()
    
    init() {
        bind()
    }
    
    private func bind() {
        input.onViewDidLoad
            .flatMap { [weak self] _ -> Observable<[SectionModel<ItemSection, GroupInfo>]> in
                guard let self = self else { return Observable.empty() }
                return self.getDataObservable().asObservable()
            }.bind(to: sectionSubject)
            .disposed(by: bag)
    }
    
    private func getDataObservable() -> Single<[SectionModel<ItemSection, GroupInfo>]> {
        return Single<[SectionModel<ItemSection, GroupInfo>]>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            
            // Single<[SectionModel<ItemSection, GroupInfo>]> 반환하는 네트워크 객체 만들기
            AF.request(SemonemoAPI.getGroupList.request.url, method: .get)
                .responseDecodable(of: [GroupInfo].self) { response in
                    switch response.result {
                    case .success(let data):
                        self.groupInfo.append(contentsOf: data)
                        single(.success([.init(model: .groupInfo, items: self.groupInfo)]))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
