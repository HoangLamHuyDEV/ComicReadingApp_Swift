//
//  comicModel.swift
//  AppTruyenTranh
//
//  Created by Huy on 23/05/2023.
//

import Foundation

public struct comic {
    var id: String
    var name: String
    var rating: Float
    var chapters: [chapter] = []
    var image: String
}
