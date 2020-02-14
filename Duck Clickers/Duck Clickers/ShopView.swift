//
//  ShopView.swift
//  Duck Clickers
//
//  Created by Anthony Li on 2/13/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI

struct ShopView: View {
    @Binding var ducks: Int
    @Binding var ducksPerClick: Int
    @Binding var price: Int
    
    var body: some View {
        List {
            Text("Your ducks: \(ducks) ducks")
            Button(action: {
                self.ducks -= self.price
                self.ducksPerClick *= 2
                self.price = Int(Double(self.price) * 2.1)
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Duck Multiplier")
                        Text("Multiplies the number of ducks per tap.").foregroundColor(.gray)
                    }
                    Spacer()
                    Text("\(self.price) ducks")
                }
            }.disabled(self.ducks < self.price)
        }.navigationBarTitle("Shop")
    }
}
