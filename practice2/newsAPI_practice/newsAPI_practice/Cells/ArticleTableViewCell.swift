//
//  ArticleTableViewCell.swift
//  newsAPI_practice
//
//  Created by 현수빈 on 2022/08/03.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView : UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let cellDisposeBag = DisposeBag()
    
    var disposeBag = DisposeBag()
    let onData: AnyObserver<Article>
    
    
    required init?(coder aDecoder: NSCoder) {
        let data = PublishSubject<Article>()
     
        onData = data.asObserver()

        super.init(coder: aDecoder)

        //ui건드니까 observe로 scheduler 변경
        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] element in
                self?.descriptionLabel.text = element.description
                self?.titleLabel.text = element.title
    
                let url = URL(string: element.urlToImage ?? "http://verona-api.municipiumstaging.it/system/images/image/image/22/app_1920_1280_4.jpg")
                let data = try? Data(contentsOf: url!)
                self?.newsImageView.image = UIImage(data: data ?? Data())
            })
            .disposed(by: cellDisposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
