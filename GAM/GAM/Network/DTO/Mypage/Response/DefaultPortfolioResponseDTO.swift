//
//  DefaultPortfolioResponseDTO.swift
//  GAM
//
//  Created by Juhyeon Byun on 1/8/24.
//

import Foundation

struct DefaultPortfolioResponseDTO: Decodable {
    let workID: Int

    enum CodingKeys: String, CodingKey {
        case workID = "workId"
    }
}
