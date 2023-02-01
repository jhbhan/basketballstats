//
//  GameListView.swift
//  ballStats
//
//  Created by Jason Bhan on 1/27/23.
//

import SwiftUI

struct GameListView: View {
    @EnvironmentObject var modelData: ModelData;
    
    var body: some View {
        NavigationStack {
            VStack{
                List(modelData.gameList){ game in
                    Section {
                        HStack {
                            Text((game.dateString())).font(Font.custom(nbafont, size: 45))
                                .foregroundColor(.purple)
                                .shadow(color: .black, radius: 5, x: 0, y: 5)
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
