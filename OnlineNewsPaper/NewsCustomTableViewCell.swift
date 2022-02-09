

import UIKit


class NewsCustomTableViewCellViewModel {
    
    let title : String
    let subtitle : String
    let imageURL : URL?
    var imageData: Data? = nil
    
    
    init(title: String, subtitle : String,  imageURL : URL?) {
        self.title = title
        self.subtitle  = subtitle
        self.imageURL = imageURL
        
    }
    
    
}



class NewsCustomTableViewCell: UITableViewCell {
    
    static let identifier = "NewCustomTableViewCell"
    
    
    
    // titleLabel
    private let newsTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        
        return label
    }()
    
    
    // subtitleLabel
    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize : 18, weight: .regular)
        
        return label
    }()
    
    
    
    // imageView
    private let newsImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray2
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImgView)
    }
    
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    override func prepareForReuse(){
        super.prepareForReuse()
    }
    
    
    
    
    
    func configure(with viewModel: NewsCustomTableViewCellViewModel ){
        
    }
    

}
