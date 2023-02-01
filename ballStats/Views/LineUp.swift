//
//  LineUp.swift
//  ballStats
//
//  Created by Jason Bhan on 1/24/23.
//

import SwiftUI

struct LineUp: View {
    @Binding var players: [PlayerStat];
    @Environment(\.dismiss) var dismiss
    
    let isLineUp: Bool;
    
    var body: some View {
        VStack{
            List($players){ $player in
                Section{
                    HStack{
                        Button(action: { }) {
                            Label("", systemImage: player.onCourt ? "star.fill" : "star").foregroundColor(.yellow)
                                .font(Font.custom(nbafont, size: 30))
                                .opacity(isLineUp ? 1 :0)

                        }
                        Text("\(player.name)")
                            .font(Font.custom(nbafont, size: 30))
                            .foregroundColor(.black)
                    }
                    .listRowBackground(Color.white)
                    .onTapGesture {
                        player.onCourt = !player.onCourt;
                    }
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
