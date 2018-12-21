import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("hello", "vapor") { req in
        return "Hello Vapor"
    }
    
//    public func get<T>(_ path: PathComponentsRepresentable..., use closure: @escaping (Request) throws -> T) -> Route<Responder>
//        where T: ResponseEncodable
//    {
//        return _on(.GET, at: path.convertToPathComponents(), use: closure)
//    }
    
    router.get("date") { req -> String in
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    router.get("counter",Int.parameter) { req -> CountJSON in
        let countVal = try req.parameters.next(Int.self)
        return (CountJSON(count:countVal))
    }
//    router.get("date") { req in
//
//    }
    
//    router.get("date") { req in
//        var date = DateTime.Now
//        return String(date)
//    }
//    public func post<C, T>(_ content: C.Type, at path: PathComponentsRepresentable..., use closure: @escaping (Request, C) throws -> T) -> Route<Responder>
//        where C: RequestDecodable, T: ResponseEncodable
//    {
//        return _on(.POST, at: path.convertToPathComponents(), use: closure)
//    }
    
//    router.post(InfoData.self, at: "info") { req, data -> String in
//        return "Hello \(data.name)"
//    }

    router.post(InfoData.self, at: "infojson") { req, data -> InfoResponse in
        return InfoResponse(request: data)
    }
    
    router.post(UserInfoData.self, at: "user-info") { req, userInfo -> String in
        //let userInfo = req as UserInfo
       // var userInfo: UserInfoData
        //let userInfo = try req.content.decode(UserInfoData.self)
        //let info = try req.parameters.next(UserInfoData.self)
        //return "Hello \(userInfo.name), you are \(userInfo.age)"
        return "Hello \(userInfo.name), you are \(userInfo.age)"
        
    }
    
  
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}


struct CountJSON: Content {
    let count: Int
}

struct UserInfoData: Codable {
    let name: String
    let age: Int
}
