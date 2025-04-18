//
//  NetworkError.swift
//  CoinPocket
//
//  Created by 조우현 on 4/18/25.
//

import Foundation

enum NetworkError: Error {

    /// 400 – 잘못된 요청
    case badRequest
    /// 401 – 인증 자격 없음
    case unauthorized
    /// 403 – 접근 차단
    case forbidden
    /// 429 – 호출 한도 초과
    case tooManyRequests
    /// 500 – 서버 내부 오류
    case internalServerError
    /// 503 – 서비스 불가
    case serviceUnavailable
    
    /// 1020 – Cloudflare Firewall에 의해 차단
    case accessDenied
    /// 10002 – API Key 불일치
    case invalidAPIKey
    /// 10005 – 유료 플랜 전용 엔드포인트
    case subscriptionRequired

    /// CORS 차단
    case corsError
    /// JSON 디코딩 실패
    case decoding(Error)
    /// Alamofire / URLSession 자체 오류
    case transport(Error)
    
    case unknown
    
    init(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 429:
            self = .tooManyRequests
        case 500:
            self = .internalServerError
        case 503:
            self = .serviceUnavailable
        case 1020:
            self = .accessDenied
        case 10002:
            self = .invalidAPIKey
        case 10005:
            self = .subscriptionRequired
        default:
            self = .unknown
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다."
        case .unauthorized:
            return "인증 정보가 유효하지 않습니다."
        case .forbidden:
            return "서버에서 요청이 거부되었습니다."
        case .tooManyRequests:
            return "호출 한도를 초과했습니다. 잠시 후 다시 시도해주세요."
        case .internalServerError:
            return "서버 내부 오류가 발생했습니다."
        case .serviceUnavailable:
            return "서비스가 일시적으로 불가능합니다."
        case .accessDenied:
            return "방화벽 정책에 의해 접근이 차단되었습니다."
        case .invalidAPIKey:
            return "API Key가 잘못되었습니다."
        case .subscriptionRequired:
            return "유료 플랜이 필요한 엔드포인트입니다."
        case .corsError:
            return "CORS 오류가 발생했습니다."
        case .decoding(let err):
            return "데이터 해석에 실패했습니다. (\(err.localizedDescription))"
        case .transport(let err):
            return "네트워크 통신에 실패했습니다. (\(err.localizedDescription))"
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
