//
//  ScheduleView.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/12/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI

struct MasterView: View {
    @ObservedObject var fetcher: ScheduleFetcher = {
        let fetcher = ScheduleFetcher()
        fetcher.fetch()
        return fetcher
    }()
        
    var body: some View {
        let view: AnyView
        if let result = fetcher.events {
            switch result {
            case .success(let events):
                view = AnyView(List(events) { event in
                    NavigationLink(destination: DetailView(event: event)) {
                        EventView(event: event)
                    }
                })
            case .failure(_):
                view = AnyView(Text("Error").foregroundColor(.red))
            }
        } else {
            view = AnyView(Text("Loading..."))
        }
        
        return view.navigationBarTitle("Schedule")
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
