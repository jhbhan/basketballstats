//
//  MainView.swift
//  ballStats
//
//  Created by Jason Bhan on 1/27/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var modelData: ModelData;
    var teamId: Int64 = 1;
    var body: some View {
        NavigationStack{
            VStack{
                Text("BASKETBALL STATS")
                        .font(Font.custom(nbafont, size: 45))
                        .foregroundColor(.purple)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                NavigationLink{
                    LineUp(players: $modelData.playerList, isLineUp: false).onAppear(perform: {modelData.getPlayerList(teamId: teamId)})
                } label: {
                    Text("Team Roster")
                        .font(Font.custom(nbafont, size: 24))
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                    .padding(12)
                    .border(.white)
                    .buttonBorderShape(.roundedRectangle)
                
                NavigationLink{
                    AddPlayer()
                } label: {
                    Text("Add Players")
                        .font(Font.custom(nbafont, size: 24))
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                    .padding(12)
                    .border(.white)
                    .buttonBorderShape(.roundedRectangle)
                
                NavigationLink{
                    TableView()
                        .onAppear(perform: {
                            _ = StatsDataStore.shared.insertGame(teamId: teamId)
                            modelData.getPlayerList(teamId: teamId)
                        })
                } label: {
                    Text("New Game")
                        .font(Font.custom(nbafont, size: 24))
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                    .padding(12)
                    .border(.white)
                    .buttonBorderShape(.roundedRectangle)

                
                NavigationLink{
                    GameListView()
                        .onAppear(perform: {modelData.getGameList(teamId: teamId)})
                } label: {
                    Text("Past Games")
                        .font(Font.custom(nbafont, size: 24))
                        .foregroundColor(.white)
                }.frame(maxWidth: .infinity)
                    .padding(12)
                    .border(.white)
                    .buttonBorderShape(.roundedRectangle)
            }
            .frame(maxHeight: .infinity)
            .foregroundColor(.black)
                .background(LinearGradient(gradient: Gradient(colors: [.gray, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }//NavStack
    }//View
}
