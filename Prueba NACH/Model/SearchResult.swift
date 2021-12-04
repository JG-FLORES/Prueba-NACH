//
//  SearchResult.swift
//  Prueba NACH
//
//  Created by Joel Guerra on 03/12/21.
//

import Foundation

struct SearchResult: Decodable {
    let colors: [String]
    let questions: [Result]
}

struct Result: Decodable {
    let total: Int
    let text: String
    let chartData: [ChartData]
}

struct ChartData: Decodable {
    let text: String
    let percetnage: Int
}
