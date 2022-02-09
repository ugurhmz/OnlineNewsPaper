

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
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .medium)
        
        return label
    }()
    
    
    // subtitleLabel
    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize : 18, weight: .regular)
        
        return label
    }()
    
    
    
    // imageView
    private let newsImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
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
    
    
    // Ekranda nasıl görünsün
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 170,
                                      height: contentView.frame.size.height/2)
        
        
        subtitleLabel.frame = CGRect(x:10,
                                     y: 70,
                                     width: contentView.frame.size.width - 170,
                                     height: contentView.frame.size.height/2
        )
        
        newsImgView.frame = CGRect(x: contentView.frame.size.width - 150,
                                   y: 5,
                                   width: 160,
                                   height: contentView.frame.size.height - 10
        )
        
        
        
    }
    
    
    override func prepareForReuse(){
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImgView.image = nil
    }
    
    
    
    
    
    func configure(with viewModel: NewsCustomTableViewCellViewModel ){
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        
        // Image
        if let data = viewModel.imageData {
            newsImgView.image = UIImage(data: data)
            
            
        }  else if let url = viewModel.imageURL {
            // fetch data
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                
                guard let data = data, error == nil else {
                    return
                }
                
                viewModel.imageData = data
                
                DispatchQueue.main.async {
                    self?.newsImgView.image = UIImage(data: data)
                }
                
            }.resume()
        }
        
    }
    

}
