//
//  ContentView.swift
//  hackSchedule
//
//  Created by Anthony Li on 2/13/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI

let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView: View {
    var body: some View {
        NavigationView {
            MasterView()
            Text("Please select an event")
        }
    }
}

struct MasterView: View {
    @ObservedObject var fetcher: EventFetcher = {
        let fetcher = EventFetcher()
        fetcher.fetch()
        return fetcher
    }()
    
    var body: some View {
        if let result = fetcher.result {
            switch result {
            case .success(let events):
                return AnyView(List(events) { event in
                    NavigationLink(destination: DetailView(event: event)) {
                        HStack {
                            Text(event.name)
                            Spacer()
                            Text("\(event.start, formatter: formatter)")
                        }
                    }
                })
            case .failure(_):
                return AnyView(List {
                    Text("Error")
                })
            }
        } else {
            return AnyView(List {
                Text("Loading...")
            })
        }
    }
}

struct DetailView: View {
    var event: Event
    
    var body: some View {
        VStack {
            Text(event.name)
            event.description.map { Text($0) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
