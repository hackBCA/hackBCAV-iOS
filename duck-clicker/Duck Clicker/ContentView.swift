//
//  ContentView.swift
//  Duck Clicker
//
//  Created by Anthony Li on 2/10/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI
import AVFoundation

var audioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "Duck", withExtension: "m4a")!)

struct ContentView: View {
    @State var clicks = UserDefaults.standard.integer(forKey: "clicks") {
        didSet {
            UserDefaults.standard.set(clicks, forKey: "clicks")
        }
    }
    @State var purchasedItems: [String: Int] = UserDefaults.standard.dictionary(forKey: "purchasedItems") as? [String: Int] ?? [:]
    
    var body: some View {
        var additionalSize: CGFloat = 0
        if let enlargement = self.purchasedItems["enlarger"] {
            additionalSize = 10 * CGFloat(enlargement)
        }
        
        return NavigationView {
            VStack {
                Text("\(clicks) ducks")
                    .font(.largeTitle).fontWeight(.bold)
                Button(action: {
                    if let multiplier = self.purchasedItems["multiplier"] {
                        self.clicks += Int(pow(2, Double(multiplier)))
                    } else {
                        self.clicks += 1
                    }
                    
                    audioPlayer?.play()
                }) {
                    Image("Duck")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200 + additionalSize, height: 100 + additionalSize)
                        .hueRotation(Angle(degrees: Double((self.purchasedItems["hue-rotater"] ?? 0) * 15)))
                        .rotationEffect(Angle(degrees: Double((self.purchasedItems["rotater"] ?? 0) * 15)))
                }
                Spacer()
                NavigationLink(destination: ShopView(clicks: $clicks, purchasedItems: $purchasedItems)) {
                    Text("Shop").font(.title)
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
