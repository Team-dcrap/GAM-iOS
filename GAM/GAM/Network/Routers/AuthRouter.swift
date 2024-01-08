//
//  AuthRouter.swift
//  GAM
//
//  Created by Jungbin on 2023/08/23.
//

import Foundation
import Moya

enum SocialType: String {
    case apple = "APPLE"
    case kakao = "KAKAO"
}

enum AuthRouter {
    case requestSocialLogin(data: SocialLoginRequestDTO)
}

extension AuthRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestSocialLogin:
            return "/social/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestSocialLogin:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestSocialLogin(let data):
            let body: [String: Any] = [
                "token": data.token,
                "providerType": data.socialType
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
