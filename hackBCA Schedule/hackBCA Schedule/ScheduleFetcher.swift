//
//  ScheduleFetcher.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/11/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import Foundation
import SwiftUI
import Yams
import Dispatch

public class ScheduleFetcher: ObservableObject {
    @Published public private(set) var events: Result<[Event], Error>?
    
    public enum FetchError: Error {
        case unableToRead
    }
    
    public func fetch() {
        let url = URL(string: "https://hackbca.com/data/schedule.yaml")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.events = .failure(error)
                } else if let data = data, let string = String(data: data, encoding: .utf8) {
                    let decoder = YAMLDecoder()
                    do {
                        let events = try decoder.decode([Event].self, from: string)
                        self.events = .success(events.sorted { $0.start < $1.start })
                    } catch (let error) {
                        self.events = .failure(error)
                    }
                } else {
                    self.events = .failure(FetchError.unableToRead)
                }
            }
        }
        task.resume()
    }
}
