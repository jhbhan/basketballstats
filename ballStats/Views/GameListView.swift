//
//  GameListView.swift
//  ballStats
//
//  Created by Jason Bhan on 1/27/23.
//

import SwiftUI

struct GameListView: View {
    @EnvironmentObject var modelData: ModelData;
    @State private var showStats = false;
    @State var showDeleteConfirmation = false;
    @State var showDeleteError = false;
    @State var selectedGameId: Int64 = 0;
    
    var body: some View {
        NavigationStack {
            VStack{
                List(modelData.gameList){ game in
                    Section {
                        HStack {
                            Button(action: {
                                showStats.toggle()
                                self.selectedGameId = game.id
                            }) {
                                Text("\(game.dateString())")
                                    .font(Font.custom(nbafont, size: 45))
                                        .foregroundColor(.purple)
                                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                            }
                            .sheet(isPresented: $showStats) {
                                TableView()
                                    .onAppear(perform: {
                                        if(self.selectedGameId == game.id){
                                            modelData.getCurrentGame(gameId: self.selectedGameId, teamId: game.teamId)
                                        }
                                    })
                            }
                        }
                    }
                }
            }//STack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.black)
                .background(LinearGradient(gradient: Gradient(colors: [.gray, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        }//NavigationStack
    }//View
}//Class
