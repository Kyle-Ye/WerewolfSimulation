//
//  PlayerCardView.swift
//  WerewolfSimulation
//
//  Created by 叶絮雷 on 2020/11/22.
//

import CoreMafia
import SwiftUI

struct PlayerCardView: View {
    @ObservedObject var player: Player
    var body: some View {
        GeometryReader{ proxy in
            VStack {
                Text("ID: \(player.id)")
                    .lineLimit(1)
                ZStack {
                    Image(player.role.description)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .border(Color.green, width: player.protected ? 10 : 0)
                        .overlay(
                            HStack{
                                VStack{
                                    Image(systemName: "\(player.position).circle.fill")
                                        .font(Font.system(size: proxy.size.width / 8))
                                        .foregroundColor(.red)
                                        .padding(.all, proxy.size.width / 20)
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                        )
                        .grayscale(player.isDead ? 0.8 : 0)
                        .blur(radius: player.isDead ? 5 : 0)
                    if player.isDead {
                        Image("dead")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                }
                HStack {
                    if proxy.size.width >= 200{
                        Text("LynchVotes: \(player.lynchVotes)")
                        Text("KillVotes: \(player.killVotes)")
                    }else{
                        Text("LV: \(player.lynchVotes)")
                        Text("KV: \(player.killVotes)")
                    }
                }
            }
        }
        .frame(minWidth:150, maxWidth: 300,minHeight: 200,maxHeight: 500)
    }
}

struct PlayerCardView_Previews: PreviewProvider {
    static var previews: some View {
        let p = Player.testPlayer
        p.protected = true
        return PlayerCardView(player: p)
            .previewLayout(.fixed(width:150, height: 300))
    }
}
