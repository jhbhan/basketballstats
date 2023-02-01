//
//  Player.swift
//  ballStats
//
//  Created by Jason Bhan on 1/26/23.
//

import Foundation

struct Player {
    let id: Int64
    let name: String
    let teamId: Int64
}

struct Team: Identifiable {
    let id: Int64
    let name: String
}

struct Game: Identifiable {
    let id: Int64
    let playedDate: Date
    let teamId: Int64
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YY/MM/dd"

        // Convert Date to String
        return dateFormatter.string(from: self.playedDate)
    }
}
