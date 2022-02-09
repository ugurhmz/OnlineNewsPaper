

import Foundation



final class APIOperation {
    static let  shared = APIOperation() // Singleton
    
    struct ConstantInfos {
        static let topHeadlinesURL = URL(string:"https://newsapi.org/v2/top-headlines?country=tr&apiKey=be74c7f94ab24622b6cb92cfe66c6542")
    }
    
    
    private init() {}
    
    
    
    public  func getTopNews(completion: @escaping (Result<[String], Error>) -> Void) {
        
        
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
    let author : String?    // Hata çıkardığı için optional yaptık.
}


// Elements of Object
struct Source : Codable {
    let name : String
}
