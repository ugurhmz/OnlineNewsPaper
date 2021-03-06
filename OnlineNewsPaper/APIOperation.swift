

import Foundation



final class APIOperation {
    static let  shared = APIOperation() // Singleton
    static let company = "apple"
    static let pageSize = "70"

    
    static let myUrl = "https://newsapi.org/v2/everything?q=\(company)&from=2022-02-08&to=2022-02-08&sortBy=popularity&pageSize=\(pageSize)&apiKey=be74c7f94ab24622b6cb92cfe66c6542"
    
    struct ConstantInfos {
        static let topHeadlinesURL = URL(string: myUrl)
        
        static let searchByQuery = "https://newsapi.org/v2/everything?sortedBy=popularity&pageSize=\(pageSize)&apiKey=be74c7f94ab24622b6cb92cfe66c6542&q="
    }
    
    
    private init() {}
    
    
    
    // API  REGULAR
    public  func getTopNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        
        guard let url = ConstantInfos.topHeadlinesURL else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            
            if let error = error {
                completion(.failure(error))
                
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)

                    print("Article arr : \(result.articles.count)")
                    completion(.success(result.articles))
                    
                 } catch {
                     completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    
    // API BY QUERY
    public func search(with query : String, completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let urlString = ConstantInfos.searchByQuery + query
        
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Search arr size : ", result.articles.count)
                    completion(.success(result.articles))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
    
}


// MODELS


struct APIResponse : Codable {
    let articles : [Article] // Array  20  items
}


// Elements of Article arr
struct Article : Codable {
    
    let source : Source // This is Object {..}
    let title : String
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let author : String?    // Hata ????kard?????? i??in optional yapt??k.
}


// Elements of Object
struct Source : Codable {
    let name : String
}
