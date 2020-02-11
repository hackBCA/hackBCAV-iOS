//
//  ShopView.swift
//  Duck Clicker
//
//  Created by Anthony Li on 2/10/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI

struct ShopItem: Identifiable {
    var id: String
    var name: String
    var description: String
    var basePrice: Int
    
    func calculatePrice(alreadyPurchased: Int) -> Int {
        Int(Double(basePrice) * pow(2.1, Double(alreadyPurchased)))
    }
}

struct ShopItemView: View {
    var item: ShopItem
    var amountPurchased: Int?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(item.name)
                    amountPurchased.map { purchased in
                        Text("x\(purchased)")
                    }
                }
                Text(item.description).foregroundColor(.gray)
            }
            Spacer()
            Text("\(item.calculatePrice(alreadyPurchased: amountPurchased ?? 0)) ducks")
        }
    }
}

struct ShopView: View {
    @Binding var clicks: Int
    @Binding var purchasedItems: [String: Int] {
        didSet {
            UserDefaults.standard.set(purchasedItems, forKey: "purchasedItems")
        }
    }
    
    var items = [
        ShopItem(id: "multiplier", name: "Duck Multiplier", description: "Multiplies the number of ducks per tap by 2.", basePrice: 200),
        ShopItem(id: "enlarger", name: "Duck Enlarger", description: "Enlarges the duck on the screen.", basePrice: 500),
        ShopItem(id: "rotater", name: "Duck Rotate", description: "Rotates the duck on the screen.", basePrice: 1),
        ShopItem(id: "hue-rotater", name: "Duck Huerotater", description: "OoH rAiNbOwS", basePrice: 2)
    ]
    
    var body: some View {
        return List {
            Text("Your ducks: \(clicks)")
            ForEach(items) { item in
                Button(action: {
                    self.clicks -= item.calculatePrice(alreadyPurchased: self.purchasedItems[item.id] ?? 0)
                    if self.purchasedItems[item.id] != nil {
                        self.purchasedItems[item.id]! += 1
                    } else {
                        self.purchasedItems[item.id] = 1
                    }
                }) {
                    ShopItemView(item: item, amountPurchased: self.purchasedItems[item.id])
                }.disabled(self.clicks < item.calculatePrice(alreadyPurchased: self.purchasedItems[item.id] ?? 0))
            }
        }.navigationBarTitle("Shop")
    }
}
