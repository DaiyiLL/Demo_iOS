//
//  ViewController.swift
//  RXSwift103_CollectionDemo
//
//  Created by Daiyi on 2021/3/17.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

struct AnimatableSectionModel {
    let title: String
    var data:[String]
}

extension AnimatableSectionModel: AnimatableSectionModelType {
    typealias Item = String
    typealias Identity = String
    
    var items: [Item] {
        return data
    }
    
    var identity: String {
        return title
    }
    
    init(original: AnimatableSectionModel, items: [String]) {
        self = original
        data = items
    }
    
    
}

class ViewController: UIViewController {

    @IBOutlet weak var addItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var longGess: UILongPressGestureRecognizer!
    
    let disposeBag = DisposeBag()
    
    let data = BehaviorRelay(value: [AnimatableSectionModel(title: "Section: 0", data: ["0-0", "1-1", "2-2"])])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel> { (_, cv, indexPath, item) -> UICollectionViewCell in
//        let dataSource = RxCollectionViewSectionedReloadDataSource<AnimatableSectionModel> { (_, cv, indexPath, item) -> UICollectionViewCell in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DemoCell
            cell.titleLabel.text = item
            return cell
        } configureSupplementaryView: { (dataSouce, cv, kind, indexPath) -> UICollectionReusableView in
            let header = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! DemoHeader
            header.titleLabel.text = dataSouce.sectionModels[indexPath.section].title
            
            return header
        }
        self.data.bind(to: self.collectionView.rx.items(dataSource: dataSource)).disposed(by: self.disposeBag)
        
        self.addItem.rx.tap
            .bind { [unowned self] in
                let section = self.data.value.count
                let items: [String] = {
                    var items = [String]()
                    let random = Int(arc4random_uniform(6) + 1)
                    
                    (0...random).forEach {
                        items.append("\(section) - \($0)")
                    }
                    return items
                }()
                var old = self.data.value
                old.append(AnimatableSectionModel(title: "Section: \(section)", data: items))
                self.data.accept(old)
            }.disposed(by: self.disposeBag)
        
        longGess.rx.event
            .bind { [unowned self] in
                switch $0.state {
                case .began:
                    guard let selIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: self.collectionView)) else {
                        break;
                    }
                    // 开始拖动
                    print("\(selIndexPath) 开始拖动")
                    self.collectionView.beginInteractiveMovementForItem(at: selIndexPath)
                case .changed:
                    let point = $0.location(in: self.collectionView)
                    print("point = \(point)")
                    self.collectionView.updateInteractiveMovementTargetPosition(point)
                case .ended:
                    self.collectionView.endInteractiveMovement()
                default:
                    self.collectionView.cancelInteractiveMovement()
                    
                }
                
            }.disposed(by: self.disposeBag)
        
    }
    
    

    
    
}

