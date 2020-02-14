//
//  ContentView.swift
//  Duck Clickers
//
//  Created by Anthony Li on 2/13/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI
import AVFoundation

let audioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "Duck", withExtension: "m4a")!)

struct ContentView: View {
    @State var ducks = 0
    @State var ducksPerTap = 1
    @State var price = 2
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(ducks) ducks").font(.largeTitle).fontWeight(.bold)
                Button(action: {
                    self.ducks += self.ducksPerTap
                    audioPlayer?.play()
                }) {
                    Image("Duck").renderingMode(.original).resizable().scaledToFit().frame(width: 300, height: 200)
                }
                NavigationLink(destination: ShopView(ducks: $ducks, ducksPerClick: $ducksPerTap, price: $price)) {
                    Text("Shop").font(.title)
                }.padding(.top)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
