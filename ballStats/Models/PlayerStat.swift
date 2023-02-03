//
//  PlayerStat.swift
//  ballStats
//
//  Created by Jason Bhan on 1/21/23.
//

import Foundation

struct PlayerStat: Identifiable {
    var id: Int64 //playerId
    var name: String
    var fga: Int64 = 0
    var fgm: Int64 = 0
    var tpa: Int64 = 0
    var tpm: Int64 = 0
    var rebound: Int64 = 0
    var assist: Int64 = 0
    var steal: Int64 = 0
    var block: Int64 = 0
    var pt: Int64 = 0
    var pf: Int64 = 0
    var onCourt: Bool = false;
    
    mutating func reset(){
        self.fga = 0;
        self.fgm = 0;
        self.tpa = 0;
        self.tpm = 0;
        self.rebound = 0;
        self.assist = 0;
        self.steal = 0;
        self.block = 0;
        self.pt = 0;
        self.pf = 0;
    }
}

func createDemoPlayer() -> [PlayerStat] {
    var demoPlayerStat: [PlayerStat] = [];
    demoPlayerStat.append(PlayerStat(id: 0, name: "Noah", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 1, name: "Jeremy", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 2, name: "Joseph", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 3, name: "Josiah", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 4, name: "Moses", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 5, name: "Soren", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 6, name: "Reed", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 7, name: "Colton", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    demoPlayerStat.append(PlayerStat(id: 8, name: "Beau", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    
    demoPlayerStat.append(PlayerStat(id: 9, name: "Pete", fga: 0, fgm: 0, tpa: 0, tpm: 0, rebound: 0, assist: 0, steal: 0, block: 0, pt: 0, pf: 0));
    
    demoPlayerStat.sort { (lhs, rhs) in return lhs.name < rhs.name }
    for index in 0...4 {
        demoPlayerStat[index].onCourt = true;
    }
    
    return demoPlayerStat;
}
