//
//  ContentView.swift
//  ballStats
//
//  Created by Jason Bhan on 1/21/23.
//

import SwiftUI
import CoreData

let nbafont = "LMS I Love This Game";

struct TableView: View {
    
    @EnvironmentObject var modelData: ModelData;
    @State private var showingSheet = false
    
    func resetStats() {
        for player in $modelData.playerList {
            player.wrappedValue.reset()
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("BASKETBALL STATS")
                        .font(Font.custom(nbafont, size: 45))
                        .foregroundColor(.purple)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                    PlayerStatsHeader()
                ForEach($modelData.playerList.filter{ $0.wrappedValue.onCourt == true }) {
                    $playerStat in
                        PlayerStatsRow(player: $playerStat)
                }
                HStack{
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        Text("Edit Line Up")
                            .font(Font.custom(nbafont, size: 24))
                            .foregroundColor(.white)
                    }.frame(maxWidth: 400)
                        .padding(12)
                        .border(.white)
                        .buttonBorderShape(.roundedRectangle)
                        .sheet(isPresented: $showingSheet) {
                            LineUp(players: $modelData.playerList, isLineUp: true)
                        }

                    Button(action: {
                        self.resetStats();
                    }) {
                        Text("Reset")
                            .font(Font.custom(nbafont, size: 24))
                            .foregroundColor(.white)
                    }.frame(maxWidth: 400)
                        .padding(12)
                        .border(.white)
                        .buttonBorderShape(.roundedRectangle)
                }
            }
            .frame(maxHeight: .infinity)
            .foregroundColor(.black)
                .background(LinearGradient(gradient: Gradient(colors: [.gray, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }
    }
}
