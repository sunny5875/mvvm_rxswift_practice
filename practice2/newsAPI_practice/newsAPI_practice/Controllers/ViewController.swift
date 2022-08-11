//
//  ViewController.swift
//  newsAPI_practice
//
//  Created by 현수빈 on 2022/08/03.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    private var articleListViewModel : ArticleListViewModelType
    
    var disposeBag = DisposeBag()
    
    
    init(viewModel: ArticleListViewModel = ArticleListViewModel()) {
        self.articleListViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        self.articleListViewModel = ArticleListViewModel()
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.bind()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.refreshControl = UIRefreshControl()
       }

    private func bind(){

        articleListViewModel.articles.asDriver().drive(tableView.rx.items(cellIdentifier: "ArticleTableViewCell", cellType: ArticleTableViewCell.self)){ (row, element, cell) in
            //여기서 각각의 기사를 cell과 연결
            cell.onData.onNext(element)
            
            
        }.disposed(by: disposeBag)
            
    }
    
   
    


}
//mvvm만 적용한 코드
//extension ViewController : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.articleListViewModel.numberOfRowsInSection(section)
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.articleListViewModel.numberOfSections
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
//        else {fatalError("no matched articleTableViewCell identifier")}
//
//        let articleVM = self.articleListViewModel.articleAtIndex(indexPath.row) //3
//        cell.descriptionLabel?.text = articleVM.description
//        cell.titleLabel?.text = articleVM.title
//        let url = URL(string: articleVM.imageUrl ?? "http://verona-api.municipiumstaging.it/system/images/image/image/22/app_1920_1280_4.jpg")
//        let data = try? Data(contentsOf: url!)
//        cell.newsImageView.image = UIImage(data: data ?? Data())
//        return cell
//    }
//
//}

