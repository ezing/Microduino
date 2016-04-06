//
//  Router.swift
//  
//
//  Created by HeHongwe on 15/11/20.
//  Copyright © 2015年 harvey. All rights reserved.
//
import UIKit
import Alamofire

enum Router: URLRequestConvertible {
   
    static var token: String?
    
    //Restfull api
    case Projects()
    case ProjectSource(projectId:String)
    case getArticles(offset:Int,limit:Int,core:String)
    case Cores()
    case Search(station:String)
    case TopicComment(parameters:[String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .TopicComment:
            return .POST
        case .Projects:
            return .GET
        case .ProjectSource:
            return .GET
        case .getArticles:
            return .GET
        case .Cores():
            return .GET
        case .Search:
            return .GET
        }
        
        
        
    }
    var path: String {
        switch self {
        case .TopicComment:
            return ServiceApi.getCores()
        case .Projects():
            return ServiceApi.getProjects()
        case .ProjectSource(let projectId):
            return ServiceApi.ProjectSource(projectId)
        case .getArticles(let offset,let limit,let core):
            return ServiceApi.getArticles(offset,limit:limit,core:core)
        case .Cores():
            return ServiceApi.getCores()
        case .Search(let station):
            return ServiceApi.getSearch(station)
        }
        
        
    }
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: path)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = Router.token {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "token")
        }
         
        
        switch self {
        case .TopicComment(let parameters):
            
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
                default:
            return mutableURLRequest
        }
    }
}
