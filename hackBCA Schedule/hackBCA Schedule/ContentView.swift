//
//  ContentView.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/12/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MasterView()
            Text("Select an event to get started.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
