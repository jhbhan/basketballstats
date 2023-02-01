import Foundation
import SQLite

class StatsDataStore {
    
    static let DIR_TASK_DB = "StatsDB"
    static let STORE_NAME = "ballstats.sqlite3"
    
    private let games = Table("games")
    private let teams = Table("teams")
    private let players = Table("players")
    private let stats = Table("stats")
    
    private let statId = Expression<Int64>("id")
    private let gameId = Expression<Int64>("gameId")
    private let playerId = Expression<Int64>("playerId")
    private let teamId = Expression<Int64>("teamId")
    
    // stats columns
    private let fga = Expression<Int64>("fga")
    private let fgm = Expression<Int64>("fgm")
    private let tpa = Expression<Int64>("tpa")
    private let tpm = Expression<Int64>("tpm")
    private let rebound = Expression<Int64>("rebound")
    private let assist = Expression<Int64>("assist")
    private let steal = Expression<Int64>("steal")
    private let block = Expression<Int64>("block")
    private let pt = Expression<Int64>("pt")
    private let pf = Expression<Int64>("pf")
    
    // players columns
    private let name = Expression<String>("name")
    //team id
    
    // team columns
    // teamId
    private let teamName = Expression<String>("teamName")
    
    // game columns
    // game id
    private let datePlayed = Expression<Date> ("gameDate")
    
    static let shared = StatsDataStore()
    
    private var db: Connection? = nil
    
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)
            print(dirPath)
            
            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                print(dbPath)
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }
    
    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(
                games.create(ifNotExists: true) { table in
                    table.column(gameId, primaryKey: .autoincrement)
                    table.column(datePlayed)
                    table.column(teamId, references: teams, teamId)
                }
//                }
            )
            print("Games Table Created...")
            
            try database.run(
                teams.create(ifNotExists: true){ table in
                    table.column(teamId, primaryKey: .autoincrement)
                    table.column(teamName)
                }
            )
            print("Teams Table Created...")
            
            try database.run(
                players.create(ifNotExists: true){ table in
                    table.column(playerId, primaryKey: .autoincrement)
                    table.column(name)
                    table.column(teamId, references: teams, teamId)
                }
            )
            print("Players Table Created...")
            
            try database.run(
                stats.create(ifNotExists: true){ table in
                    table.column(statId, primaryKey: .autoincrement)
                    table.column(gameId, references: games, gameId)
                    table.column(playerId, references: players, playerId)
                    table.column(fga, defaultValue: 0)
                    table.column(fgm, defaultValue: 0)
                    table.column(tpa, defaultValue: 0)
                    table.column(tpm, defaultValue: 0)
                    table.column(rebound, defaultValue: 0)
                    table.column(assist, defaultValue: 0)
                    table.column(steal, defaultValue: 0)
                    table.column(block, defaultValue: 0)
                    table.column(pt, defaultValue: 0)
                    table.column(pf, defaultValue: 0)
                }
            )
            print("Stats Table Created...")
        } catch {
            print(error)
        }
    }
    
    func insertTeam(name: String) -> Int64? {
        guard let database = db else { return nil }
        
        let insert = teams.insert(self.teamName <- name)
        do {
            let rowId = try database.run(insert)
            return rowId
        } catch {
            print(error)
            return nil
        }
    }
    
    func insertPlayer(name: String, teamId: Int64) -> Int64? {
        guard let database = db else {return nil}
        
        let insert = players.insert(self.name <- name,
                                    self.teamId <- teamId)
        
        do {
            let rowId = try database.run(insert)
            return rowId
        } catch {
            print(error)
            return nil
        }
    }
    
    func insertGame(teamId: Int64) -> Int64? {
        guard let database = db else {return nil}
        
        let today = Date()
        
        let insert = games.insert(self.datePlayed <- today,
                                  self.teamId <- teamId)
        
        do {
            let gameId = try database.run(insert)
            insertGameStatsForTeam(teamId: teamId, gameId: gameId)
            return gameId
        } catch {
            print(error)
            return nil
        }
    }
    
    func insertGameStatsForTeam(teamId: Int64, gameId: Int64) {
        guard let database = db else {return}

        let players = getAllPlayersOnTeam(teamId)
        
        for player in players {
            let insert = stats.insert(self.playerId <- player.id,
                                      self.gameId <- gameId,
                                      self.fga <- 0,
                                      self.fgm <- 0,
                                      self.tpa <- 0,
                                      self.tpm <- 0,
                                      self.rebound <- 0,
                                      self.assist <- 0,
                                      self.steal <- 0,
                                      self.block <- 0,
                                      self.pt <- 0,
                                      self.pf <- 0)
            
            do {
                try database.run(insert)
            } catch {
                print(error)
                return
            }
        }
    }
    
    func getAllPlayersOnTeam(_ playerTeamId: Int64) -> [PlayerStat] {
        var players: [PlayerStat] = []
        guard let database = db else { return [] }
        do {
            for player in try database.prepare(self.players.filter(playerTeamId == teamId)) {
                players.append(PlayerStat(id: player[playerId], name: player[name]))
            }
        } catch {
            print(error)
        }
        return players
    }
    
    func getAllTeam() -> [Team] {
        var teams: [Team] = []
        guard let database = db else { return [] }

        do {
            for team in try database.prepare(self.teams) {
                teams.append(Team(id: team[playerId], name: team[name]))
            }
        } catch {
            print(error)
        }
        return teams
    }
    
    func getAllGamesForTeam(_ gameTeamId: Int64) -> [Game] {
        var games: [Game] = []
        guard let database = db else { return [] }

        do {
            for game in try database.prepare(self.games) {
                games.append(Game(id: game[gameId], playedDate: game[datePlayed], teamId: game[teamId]))
            }
        } catch {
            print(error)
        }
        return games
    }
    
    func getGameStats(getGameId: Int64, getTeamId: Int64) -> [PlayerStat]{
        var players: [PlayerStat] = []
        guard let database = db else { return [] }
        do {
            for player in try database.prepare(self.stats.filter(gameId == getGameId && teamId == getTeamId)) {
                players.append(PlayerStat(id: player[playerId], name: player[name], fga: player[fga]))
            }
        } catch {
            print(error)
        }
        return players
    }
}
