//
//  ModelData.swift
//  ballStats
//
//  Created by Jason Bhan on 1/31/23.
//

import Foundation

class ModelData: ObservableObject{
    @Published var gameList: [Game] = [];
    @Published var playerList: [PlayerStat] = [];
    
    func getCurrentGame(gameId: Int64, teamId: Int64){
        self.playerList = StatsDataStore.shared.getGameStats(getGameId: gameId, getTeamId: teamId)
    }
    
    func getGameList(teamId: Int64) {
        self.gameList = StatsDataStore.shared.getAllGamesForTeam(teamId)
    }
    
    func getPlayerList(teamId: Int64){
        self.playerList = StatsDataStore.shared.getAllPlayersOnTeam(teamId)
    }
}
