//
//  PlayerStatsRow.swift
//  ballStats
//
//  Created by Jason Bhan on 1/21/23.
//

import SwiftUI

struct PlayerStatsRow: View {
    @Binding var player: PlayerStat;
    
    var buttonHeld = false;
    
    func increment(_ number: inout Int64, _ value: Int64 = 1) {
        number += value;
    }
    
    func decrement(_ number: inout Int64, _ value: Int64 = 1) {
        number -= value;
    }
    
    var body: some View {
        HStack(alignment: .center){
            Text(self.player.name)
                .frame(width: 150, alignment: .leading)
                .padding([.trailing, .leading],25)
                .padding([.top, .bottom], 12)
                .border(.black)
                .fontWeight(.bold)
                .foregroundColor(.white)
            HStack() {
                // FGA BUTTON
                Button(action: {
                    increment(&self.player.fga)}) {
                    Text("\(self.player.fga)")
                }.frame(maxWidth: .infinity)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.fga)}))
                
                // FGM BUTTON
                Button(action: {
                    increment(&self.player.fga);
                    increment(&self.player.fgm);
                    increment(&self.player.pt, 2);
                }) {
                    Text("\(self.player.fgm)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in
                    decrement(&self.player.fga);
                    decrement(&self.player.fgm);
                    decrement(&self.player.pt, 2);}))
                
                // TPA BUTTON
                Button(action: { increment(&self.player.tpa)}) {
                    Text("\(self.player.tpa)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.tpa)}))
                
                // TPM BUTTON
                Button(action: {
                    increment(&self.player.tpa);
                    increment(&self.player.tpm);
                    increment(&self.player.pt, 3);
                }) {
                    Text("\(self.player.tpm)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in
                    decrement(&self.player.tpa);
                    decrement(&self.player.tpm);
                    decrement(&self.player.pt, 3);}))
                
                // POINT BUTTON
                Button(action: { increment(&self.player.pt)}) {
                    Text("\(self.player.pt)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.pt)}))
                
                // ASSIST BUTTON
                Button(action: { increment(&self.player.assist)}) {
                    Text("\(self.player.assist)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.assist)}))
                
                // REBOUND BUTTON
                Button(action: { increment(&self.player.rebound)}) {
                    Text("\(self.player.rebound)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.rebound)}))
                
                // BLOCK BUTTON
                Button(action: { increment(&self.player.block)}) {
                    Text("\(self.player.block)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.block)}))
                
                // STEAL BUTTON
                Button(action: { increment(&self.player.steal)}) {
                    Text("\(self.player.steal)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.steal)}))
                
                // PF BUTTON
                Button(action: { increment(&self.player.pf)}) {
                    Text("\(self.player.pf)")
                }.frame(maxWidth: .infinity)
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded({_ in decrement(&self.player.pf)}))
            }
            .frame(maxWidth: .infinity)
            .padding([.trailing, .leading],25)
            .padding([.top, .bottom], 12)
            .border(.black)
         }
        .frame(maxWidth: .infinity)
        .font(.title)
    }
}

struct PlayerStatsRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsRow(player: .constant(createDemoPlayer()[0]))
    }
}
