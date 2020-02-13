//
//  DetailView.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/12/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var event: Event
    
    let dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(event.name).font(.largeTitle).fontWeight(.bold).fixedSize(horizontal: false, vertical: true)
                Group {
                    if event.end == nil {
                        Text("\(event.start, formatter: dateFormatter)")
                    } else {
                        Text("\(event.start, formatter: dateFormatter) - \(event.end!, formatter: dateFormatter)")
                    }
                }.font(.title)
                
                Group {
                    event.presenter.map { Text($0) }
                    event.location.map { Text($0) }
                }.font(.headline)
                
                event.description.map { Text($0).padding(.top) }.fixedSize(horizontal: false, vertical: true)
                
                event.requirements.map { requirements in
                    Group {
                        Text("Requirements").font(.headline).padding(.top)
                        Text(requirements).fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                MapView(event: event).frame(minWidth: 0, maxWidth: .infinity, idealHeight: 400).padding(.top)
            }.padding(.horizontal)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(event: Event(type: .workshop, name: "Hypothetical Workshop About iOS", presenter: "Hypothetical Presenter", description: "Hypotheticfshiajhsdfiouqwyoruq7hwoeiryhpoqweiyrh1827g3094861920834g61902836ey49816t2398uydfbkjksjhzmnxcbvm,znxbcvm,znxbcv,kjahkduyqo5r6928634912uy34al description93y4 8109487087", start: Date(), end: Date(), location: "Room 13", requirements: "Hypothetical requirement"))
    }
}
