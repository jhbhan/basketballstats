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
    @Published var selectedGameId: Int64 = 0;
    
    func getCurrentGame(gameId: Int64, teamId: Int64){
        self.selectedGameId = gameId
        self.playerList = StatsDataStore.shared.getGameStats(getGameId: gameId)
    }
    
    func getGameList(teamId: Int64) {
        self.gameList = StatsDataStore.shared.getAllGamesForTeam(teamId)
    }
    
    func getPlayerList(teamId: Int64){
        self.playerList = StatsDataStore.shared.getAllPlayersOnTeam(teamId)
    }
    
    func updatePlayerStats(){
        //TODO: Errror Catching
        _ = StatsDataStore.shared.updateStats(players: self.playerList, gameId: self.selectedGameId);
    }
}
