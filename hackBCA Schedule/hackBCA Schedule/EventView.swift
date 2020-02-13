//
//  EventView.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/12/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI
import Foundation

struct EventView: View {
    var event: Event
    
    let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.name).font(.headline)
                event.presenter.map { Text($0).font(.subheadline) }
                event.description.map { Text($0.replacingOccurrences(of: "\n", with: " ")).lineLimit(1).font(.subheadline).foregroundColor(.gray) }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(dateFormatter.string(from: event.start))
                event.location.map { Text($0).foregroundColor(.gray) }
            }
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(type: .workshop, name: "Hypothetical Workshop", presenter: "Hypothetical Presenter", description: "Hypothetical description", start: Date(), end: nil, location: "Room 13", requirements: nil)).previewLayout(.sizeThatFits)
    }
}
