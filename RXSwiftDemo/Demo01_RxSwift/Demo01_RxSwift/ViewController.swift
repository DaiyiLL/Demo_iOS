//
//  ViewController.swift
//  Demo01_RxSwift
//
//  Created by yidai on 2019/8/7.
//  Copyright © 2019 daishuyi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    // 歌曲列表数据源
    let viewModel = MusicListViewModel()
    
    // 负责对象销毁
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView)
        
        // 将数据源数据绑定t到TableView上
        self.viewModel.data
            .bind(to: self.tableView.rx.items(cellIdentifier: "UITableViewCell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
        }.disposed(by: self.disposeBag)
        
        self.tableView.rx.modelSelected(Music.self).subscribe({
            music in
            print("你选中的歌曲信息 【\(music)】")
        }).disposed(by: self.disposeBag);
        
    }
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.white
//        tableView.delegate = self
//        tableView.dataSource = self;
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        return tableView;
    }()


}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
//        
//        let music = self.viewModel.data[indexPath.row]
//        cell.textLabel?.text = music.name
//        cell.detailTextLabel?.text = music.singer
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.data.count
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("你选中的歌曲信息[\(self.viewModel.data[indexPath.row])]")
//    }
//}

