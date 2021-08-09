//
//  CovidModel.swift
//  IOS3_COVID_FINAL
//
//  Created by Marlon Machado on 08/08/21.
//

import Foundation

// MARK: - Covid
struct CovidModel: Codable {
    let hits: Hits?
}

// MARK: - Hits
struct Hits: Codable {
    let hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable {
    let source: Source?

    enum CodingKeys: String, CodingKey {
        case source = "_source"
    }
}

// MARK: - Source
struct Source: Codable {
    let estado: String?
    let estadoSigla: String?
    let municipio: String?
    let dataNotificacaoOcupacao: String?
    let obitos: Int?
    let ofertaRespiradores: Int?
    let nomeCnes: String?
    let ofertaHospUti: Int?
}
