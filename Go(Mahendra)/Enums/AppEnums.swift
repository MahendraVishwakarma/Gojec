import Foundation

// generics type
public enum Result<T, U> where U:Error{
    case success(T)
    case failure(U)
}

// custom error
public enum APIError:Error{
    case failedRequest(String?)
    var localizedDescription: String {
        switch self {
        case .failedRequest(let message): return message ?? ""
        }
    }
    
}

// hTTPS methods type
public enum HttpsMethod{
    case Post
    case Get
    case Put
    case Delate
    
    var localization:String{
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
        case .Put: return "PUT"
        case .Delate: return "Delete"
            
        }
        
    }
}

enum HttpURL {
    case Contact
    var url : String{
        switch self {
        case .Contact: return Messages.contact_url
        }
    }
}

enum ContactAction {
    case edit
    case add
}


