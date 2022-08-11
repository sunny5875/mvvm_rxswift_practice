//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"



class ViewController: UIViewController {

    @IBOutlet weak var memberTableView: UITableView!
    
    //    var data: [Member] = []
    
    var disposeBag = DisposeBag()

    var viewModel : ViewModel
    
    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = ViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: coder) //이거 안써주면 table view nil된다!! 조심!!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        
    }

    
    func bind(){
        memberTableView.refreshControl = UIRefreshControl()
        
        
        viewModel.memberList.asDriver().drive(memberTableView.rx.items(cellIdentifier: "MemberItemCell", cellType: MemberItemCell.self)){_,element,cell in
            cell.onData.onNext(element)
        }.disposed(by: disposeBag)
        
        
        
        // 페이지 이동 : segue를 못보내네... 이걸 이렇게 해야 한다니.. 이것도 viewModel이 해야하는 일이다!!
        memberTableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
              let cell = self?.memberTableView.cellForRow(at: indexPath) as? MemberItemCell
              self?.performSegue(withIdentifier: "DetailViewController",sender: cell?.element)
            }).disposed(by: disposeBag)
       


        
        
//        viewModel.loadMembers()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] members in
//                self?.viewModel.data = members
//                self?.tableView.reloadData()
//            })
//            .disposed(by: disposeBag)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            id == "DetailViewController",
            let detailVC = segue.destination as? DetailViewController,
            let data = sender as? Member else {
            return
        }
        detailVC.data = data
    }
}

// MARK: TableView DataSource

//extension ViewController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberItemCell") as! MemberItemCell
//        let item = data[indexPath.row]
//
//        cell.setData(item)
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = data[indexPath.row]
//        performSegue(withIdentifier: "DetailViewController", sender: item)
//    }
//}
