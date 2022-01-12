//
//  AlbumCover.swift
//  AudioPlayer
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI

struct MusicCoverView: View {
    @ObservedObject var audioGobalVaribles = AudioGobalVaribles()
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 5)
                .frame(width: screenWidth*0.85, height: screenHeight*0.4, alignment: .center)
                .foregroundColor(Color.white)
            Image("cover_1")
                .resizable()
                .frame(width: screenWidth*0.85, height: screenHeight*0.4, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct MusicCoverView_Previews: PreviewProvider {
    static var previews: some View {
        MusicCoverView()
    }
}
