
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // tableView register
    private let tableView : UITableView = {
        let table = UITableView()
        
        
        // custom tableViewCell register.
        table.register(NewsCustomTableViewCell.self,
                       forCellReuseIdentifier: NewsCustomTableViewCell.identifier)
        
        
        
        return table
    }()
    
    
    private var viewModels = [NewsCustomTableViewCellViewModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Online Newspaper"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        print("wqeqweqw")
        
        
        // API DATAS
        APIOperation.shared.getTopNews { [weak self] result in
            
            switch result {
                
                case .success(let articles):
                self?.viewModels = articles.compactMap({
                    NewsCustomTableViewCellViewModel(
                        title: $0.title,
                        subtitle: $0.description ?? "-",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt ?? "-"
                    )
                })
                
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                case .failure(let error) :
                    print(error)
                
            }
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    
    
    
    
    
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(
            
            withIdentifier: NewsCustomTableViewCell.identifier,
            for : indexPath
            
        ) as? NewsCustomTableViewCell else {
            fatalError()
        }
     
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
    }
    
    
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}

