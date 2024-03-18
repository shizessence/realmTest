//
//  RealmStuff 2.swift
//  -18-03-24
//
//  Created by swift on 18.03.2024.
//

import Foundation
import RealmSwift

class Country: Object {
    @Persisted var name: String
    @Persisted var capital: String
    @Persisted var area: Double
    @Persisted var population: Int
    @Persisted var languages: List<String>
}
