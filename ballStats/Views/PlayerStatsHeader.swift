//
//  PlayerStatsRow.swift
//  ballStats
//
//  Created by Jason Bhan on 1/21/23.
//

import SwiftUI

struct PlayerStatsHeader: View {
    var body: some View {
        HStack(alignment: .center){
            Text("Name")
                .frame(width: 150, alignment: .leading)
                .padding([.top, .leading, .trailing],25)
                .foregroundColor(.white)
            HStack() {
                Text("FGA")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("FGM")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("3PA")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("3PM")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("PT")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("A")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("R")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("B")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("S")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                Text("PF")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .leading, .trailing],25)
         }
        .frame(maxWidth: .infinity)
        .font(.title)
    }
}

struct PlayerStatsHeader_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsHeader()
    }
}
