//
//  DesignerRouter.swift
//  GAM
//
//  Created by Jungbin on 2023/08/24.
//

import Foundation
import Moya

enum DesignerRouter {
    case getPopularDesigner
    case requestScrapDesigner(data: ScrapDesignerRequestDTO)
    case getBrowseDesigner
    case getScrapDesigner
    case searchDesigner(data: String)
    case getUserProfile(data: GetUserProfileRequestDTO)
}

extension DesignerRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPopularDesigner:
            return "/user/popular"
        case .requestScrapDesigner:
            return "/user/scrap"
        case .getBrowseDesigner:
            return "/user"
        case .getScrapDesigner:
            return "/user/scraps"
        case .searchDesigner:
            return "/user/search"
        case .getUserProfile:
            return "/user/detail/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopularDesigner, .getBrowseDesigner, .getScrapDesigner, .searchDesigner, .getUserProfile:
            return .get
        case .requestScrapDesigner:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getPopularDesigner, .getBrowseDesigner, .getScrapDesigner:
            return .requestPlain
        case .requestScrapDesigner(let data):
            return .requestJSONEncodable(data)
        case .searchDesigner(let data):
            let body: [String : Any] = [
                "keyword": data
            ]
            return .requestParameters(parameters: body, encoding: URLEncoding.queryString)
        case .getUserProfile(let data):
            let query: [String: Any] = [
                "userId": data.userId
            ]
            return .requestParameters(parameters: query, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": UserInfo.shared.accessToken
        ]
    }
}
