//
//  AuthService.swift
//  GAM
//
//  Created by Jungbin on 2023/08/23.
//

import Foundation
import Moya

internal protocol AuthServiceProtocol {
    func requestSocialLogin(data: SocialLoginRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func requestRefreshToken(data: RefreshTokenRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func requestLogout(data: LogoutRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
    func requestSecession(data: SecessionRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void))
}

final class AuthService: BaseService {
    static let shared = AuthService()
    private lazy var provider = GamMoyaProvider<AuthRouter>(isLoggingOn: true)
    
    private override init() {}
}

extension AuthService: AuthServiceProtocol {
    
    // [POST] 소셜로그인
    
    func requestSocialLogin(data: SocialLoginRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestSocialLogin(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, SocialLoginResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                gamPrint(error)
            }
        }
    }
    
    // [POST] 토큰 재발급
    
    func requestRefreshToken(data: RefreshTokenRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestRefreshToken(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, RefreshTokenResponseDTO.self)
                completion(networkResult)
            case .failure(let error):
                gamPrint(error)
            }
        }
    }
    
    // [POST] 로그아웃
    
    func requestLogout(data: LogoutRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestLogout(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                gamPrint(error)
            }
        }
    }
    
    // [DELETE] 탈퇴
    func requestSecession(data: SecessionRequestDTO, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        self.provider.request(.requestSecession(data: data)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, String.self)
                completion(networkResult)
            case .failure(let error):
                gamPrint(error)
            }
        }
    }
}
