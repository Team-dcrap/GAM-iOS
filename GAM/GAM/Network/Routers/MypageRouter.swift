//
//  MypageRouter.swift
//  GAM
//
//  Created by Juhyeon Byun on 1/8/24.
//

import Foundation
import Moya

enum MypageRouter {
    case getPortfolio
    case setRepPortfolio(data: SetPortfolioRequestDTO)
    case deletePortfolio(data: SetPortfolioRequestDTO)
    case createPortfolio(data: CreatePortfolioRequestDTO)
    case getImageUrl(data: ImageUrlRequestDTO)
}

extension MypageRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPortfolio:
            return "/user/my/portfolio"
        case .setRepPortfolio:
            return "/work/main"
        case .deletePortfolio, .createPortfolio:
            return "/work"
        case .getImageUrl:
            return "/s3/image"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPortfolio, .getImageUrl:
            return .get
        case .setRepPortfolio:
            return .patch
        case .deletePortfolio:
            return .delete
        case .createPortfolio:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getPortfolio:
            return .requestPlain
        case .setRepPortfolio(let data), .deletePortfolio(let data):
            return .requestJSONEncodable(data)
        case .createPortfolio(let data):
            return .requestJSONEncodable(data)
        case .getImageUrl(let data):
            let params: [String: Any] = [
                "fileName": data.imageName
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    
    var headers: [String: String]? {
        switch self {
        case .getPortfolio, .setRepPortfolio, .deletePortfolio, .createPortfolio, .getImageUrl:
            return [
                "Content-Type": "application/json",
                "Authorization": UserInfo.shared.accessToken
            ]
        }
    }
}
