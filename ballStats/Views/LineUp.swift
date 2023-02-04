//
//  LineUp.swift
//  ballStats
//
//  Created by Jason Bhan on 1/24/23.
//

import SwiftUI

struct LineUp: View {
    @EnvironmentObject var modelData: ModelData;
    @State var showDeleteConfirmation: Bool = false;
    @State var showDeleteError: Bool = false;
    @State var isPresentingConfirm: Bool = false;
    @State var selectedPlayerId: Int64 = 0;
    @State var selectedPlayerName: String = 0;
    
    @Environment(\.dismiss) var dismiss
    
    let isLineUp: Bool;
    
    func onClickDelete(_ playerId: Int64){
        let success = StatsDataStore.shared.deletePlayer(id: playerId)
        if(success){
            showDeleteConfirmation = true
            modelData.getPlayerList(teamId: 1)
        }
        else{
            showDeleteError = true
        }
    }
    
    var body: some View {
        VStack{
            List($modelData.playerList){ $player in
                Section{
                    HStack{
                        Button(action: {
                                if(isLineUp){
                                    player.onCourt = !player.onCourt;
                                }
                        }) {
                            Label("", systemImage: player.onCourt ? "star.fill" : "star").foregroundColor(.yellow)
                                .font(Font.custom(nbafont, size: 30))
                                .opacity(isLineUp ? 1:0)
                        }
                        Button(action: {
                            if(!isLineUp){
                                self.isPresentingConfirm = true
                                self.selectedPlayerId = player.id
                            }
                        }) {
                            Label("", systemImage: "trash.fill").foregroundColor(.red)
                                .font(Font.custom(nbafont, size: 30))
                                .opacity(isLineUp ? 0:1)
                        }
                        .alert("Are you sure?",
                                            isPresented: $isPresentingConfirm) {
                             Button("Delete all items?", role: .destructive) {
                                 if(!isLineUp && player.id == self.selectedPlayerId){
                                     self.selectedPlayerName = player.name
                                     self.onClickDelete(self.selectedPlayerId)
                                 }
                              }
                            }
                        .alert("Successfully deleted \(self.selectedPlayerName)", isPresented: $showDeleteConfirmation) {
                            Button("OK", role: .cancel) { }
                        }
                        .alert("Error in Deleting", isPresented: $showDeleteError) {
                            Button("OK", role: .cancel) { }
                        }
                        
                        
                        Text("\(player.name)")
                            .font(Font.custom(nbafont, size: 30))
                            .foregroundColor(.black)
                    }
                    .listRowBackground(Color.white)
                }
            }
            
            Button(action: {
                dismiss()
            }) {
                Text("CLose")
                    .font(Font.custom(nbafont, size: 24))
                    .foregroundColor(.white)
            }.frame(maxWidth: 400)
                .padding(12)
                .border(.white)
                .buttonBorderShape(.roundedRectangle)
        }
        .frame(maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.gray, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
            .scrollContentBackground(.hidden)
    }
}
