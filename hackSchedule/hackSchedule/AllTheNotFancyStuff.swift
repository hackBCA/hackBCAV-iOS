//
//  AllTheNotFancyStuff.swift
//  hackSchedule
//
//  Created by Anthony Li on 2/13/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI
import Yams

enum EventFetcherError: Error {
    case httpError
    case parsingError
}

struct Event: Codable, Identifiable {
    var id: String { name }
    
    var name: String
    var description: String?
    var start: Date
    var requirements: String?
}

class EventFetcher: ObservableObject {
    @Published var result: Result<[Event], Error>?
    
    func fetch() {
        let dataTask = URLSession.shared.dataTask(with: URL(string: "https://hackbca.com/data/schedule.yaml")!) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    let string = String(data: data, encoding: .utf8)!
                    do {
                        let events = try YAMLDecoder().decode([Event].self, from: string)
                        self.result = .success(events.sorted { $0.start < $1.start })
                    } catch _ {
                        self.result = .failure(EventFetcherError.parsingError)
                    }
                } else {
                    self.result = .failure(EventFetcherError.httpError)
                }
            }
        }
        
        dataTask.resume()
    }
}
