//
//  Component.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import UIKit

public protocol Component {
    associatedtype ComponentState: Equatable
    var state: ComponentState { get set }
    func render(with state: ComponentState) 
    func set(newState: ComponentState)
}

extension Component {
    mutating func set(newState: ComponentState) {
        guard state != newState else { return }
        self.state = newState
        self.render(with: newState)
    }
}


func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let section = sections[indexPath.section]
    
    switch kind {
    case UICollectionElementKindSectionHeader:
        //아래 모델에서 뷰를 얻지 않게 한다.
        return section.headerComponentModel?.viewFor(collectionView: collectionView, kind: UICollectionElementKindSectionHeader, at: indexPath) ?? UICollectionReusableView()
        //외부에서 컴포넌트를 등록할 때 어댑터에 추가할 정보를 Wrapping 하는 것을 하나 만든다.
        //collectionView.register(component: HeaderComponent.self, type: .header)
        // -> 이렇게 하면 내부에서는 CollectionCellInfo(viewClass, type) 을 담아 놓는다.
        //섹션은 어떻게 하는가?
        // -> 사용하는 측에서는 컬렉션뷰를 몰랐으면 좋겠다.
        //즉, collectionView.register(component: HeaderComponent.self, type: .header) 이것도 몰라야 한다.
        //ListComponent가 되어야 하고
        //ListComponent(container: collectionView, layout: collectionViewLayout ... ) 또는
        //ListComponent(container: tableView, ... ) 가 되어야 한다.
        //그렇게 해서 인터페이스가 통일되어야 한다.
        //ListComponent.register(component: Component, type: .header)
        //ListComponent.register(component: Component, type: .footer)
        //ListComponent.register(component: Component)
        //ListComponent.set(components: [SectionComponentModel])
        //SectionComponentModel(component: [ComponentModel], header: ComponentModel, footer: ComponentModel)
        //ComponentModel -> Component와 State를 묶어주는 프로토콜
        //protocol ComponentModel {
        //  var component: Component.Type
        //  var state: ComponentState.Type
        //}
        
    case UICollectionElementKindSectionFooter:
        return section.footerComponentModel?.viewFor(collectionView: collectionView, kind: UICollectionElementKindSectionFooter, at: indexPath) ?? UICollectionReusableView()
        
    default:
        return UICollectionReusableView()
    }
    
}

