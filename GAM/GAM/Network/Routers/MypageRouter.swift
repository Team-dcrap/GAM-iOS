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
    case uploadImage(data: UploadImageRequestDTO)
    case updateLink(contactUrlType: ContactURLType, data: UpdateLinkRequestDTO)
    case updatePortfolio(data: UpdatePortfolioRequestDTO)
    case getProfile
    case updateProfile(data: UpdateProfileRequestDTO)
}

extension MypageRouter: TargetType {
    
    var baseURL: URL {
        switch self {
        case .uploadImage(let data):
            return URL(string: data.uploadUrl)!
        default:
            return URL(string: APIConstants.baseURL)!
        }
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
        case .uploadImage:
            return ""
        case .updateLink(let contactUrlType, _):
            return "/user/link/\(contactUrlType.rawValue)"
        case .updatePortfolio:
            return "/work/edit"
        case .getProfile:
            return "/user/my/profile"
        case .updateProfile:
            return "/user/introduce"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPortfolio, .getImageUrl, .getProfile:
            return .get
        case .setRepPortfolio, .updateLink, .updatePortfolio, .updateProfile:
            return .patch
        case .deletePortfolio:
            return .delete
        case .createPortfolio:
            return .post
        case .uploadImage:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .getPortfolio, .getProfile:
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
        case .uploadImage(let data):
            return .requestData(data.imageData.jpegData(compressionQuality: 0.8) ?? Data())
        case .updateLink(_, let data):
            return .requestJSONEncodable(data)
        case .updatePortfolio(let data):
            return .requestJSONEncodable(data)
        case .updateProfile(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    
    var headers: [String: String]? {
        switch self {
        case .uploadImage:
            return [
                "Content-Type": "image/jpeg"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": UserInfo.shared.accessToken
            ]
        }
    }
}