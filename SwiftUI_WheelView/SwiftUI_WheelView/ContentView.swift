//
//  ContentView.swift
//  SwiftUI_WheelView
//
//  Created by zaehorang on 9/29/24.
//

import SwiftUI

struct ContentView: View {
    let wheelValues = [MyValue(val: "1"), MyValue(val: "2"), MyValue(val: "3"), MyValue(val: "4"), MyValue(val: "5"), MyValue(val: "6"), MyValue(val: "7"), MyValue(val: "8"), MyValue(val: "9"), MyValue(val: "10")]
    
    var body: some View {
        WheelView(myValues: wheelValues, circleSize: 200)
    }
}

#Preview {
    ContentView()
}
