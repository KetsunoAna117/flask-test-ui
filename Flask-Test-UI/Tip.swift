//
//  ShowTip.swift
//  Flask-Test-UI
//
//  Created by Hans Arthur Cupiterson on 07/10/24.
//

import TipKit

struct PopupTip: Tip {
    var title: Text
    var message: Text?
    var image: Image?
}

struct InViewTip: Tip {
    static let setEvent = Event(id: "setEvent")
    static let eventTriggeredEvent = Event(id: "eventTriggered")
    
    var title: Text
    var message: Text?
    
    var rules: [Rule] {
        #Rule(InViewTip.eventTriggeredEvent) { event in
            event.donations.count >= 5
        }
    }
    
}
