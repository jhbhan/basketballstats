//
//  AddPlayer.swift
//  ballStats
//
//  Created by Jason Bhan on 1/26/23.
//

import SwiftUI
import Foundation

struct AddPlayer: View {
    @EnvironmentObject var modelData: ModelData;
    @State var playerName: String = "";
    @State var showConfirmation: Bool = false;
    @State var showError: Bool = false;
    
    func onClickSave() {
        let id = StatsDataStore.shared.insertPlayer(name: playerName, teamId: 1)
        if(id != nil){
            showConfirmation = true;
        }
        else{
            showError = true
        }
    }
    
    var body: some View {
        VStack{
            Text("Add Player")
                .font(Font.custom(nbafont, size: 45))
                .foregroundColor(.purple)
                .shadow(color: .black, radius: 5, x: 0, y: 5)
            TextField(text: $playerName, prompt: Text("Player Name")) {
                    Text("Player Name")
                }
            .font(Font.custom(nbafont, size: 45))
            .frame(width: 600, height: 60)
            .multilineTextAlignment(.center)
            .padding(20)
            
            Button(action: {
                self.onClickSave()
            }) {
                Text("Save")
                    .font(Font.custom(nbafont, size: 24))
                    .foregroundColor(.white)
            }.frame(maxWidth: 400)
                .padding(12)
                .border(.white)
                .buttonBorderShape(.roundedRectangle)
                .alert("Successfully Added \(playerName)", isPresented: $showConfirmation) {
                            Button("OK", role: .cancel) { }
                        }
                .alert("Error in Saving", isPresented: $showError) {
                            Button("OK", role: .cancel) { }
                        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.black)
            .background(LinearGradient(gradient: Gradient(colors: [.gray, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}
