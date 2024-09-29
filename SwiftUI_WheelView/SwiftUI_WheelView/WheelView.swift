//
//  WheelView.swift
//  SwiftUI_WheelView
//
//  Created by zaehorang on 9/29/24.
//

import SwiftUI

struct WheelView: View {
    // Circle Radius
    // 값들을 중심에서 얼마나 떨어지게 할 것인지
    @State var radius: Double = 0
    
    // Direction of swipe
    @State var direction = Direction.up
    // index of the number at the bottom of the circle
    @State var chosenIndex = 0
    
    // degree of circle and hue
    //    @Binding var degree : Double
    // 0은 오른쪽 시작, -90은 위 시작, 90은 아래 시작
    // wheel 전체를 조절하는 값
    @State var degree = 0.0
    
    let array : [MyValue]
    let circleSize : Double
    
    
    var body: some View {
        
        ZStack {
            let anglePerCount = Double.pi * 2.0 / Double(array.count)
            
            let drag = DragGesture()
                .onEnded { value in
                    print(value)
                    if value.startLocation.y < value.location.y - 10 {
                        direction = .down
                    } else if value.startLocation.y > value.location.y + 10 {
                        direction = .up
                    }
                    moveWheel()
                }
            
            // MARK: WHEEL STACK - BEGINNING
            ZStack {
                // wheel 배경
                Circle().fill(EllipticalGradient(colors: [.orange,.yellow]))
                    .hueRotation(Angle(degrees: degree))
                
                
                ForEach(0..<array.count, id: \.self) { index in
                    // 각 요소들의 각을 잡아 줄 변수
                    let angle = Double(index) * anglePerCount
                    
                    let xOffset = CGFloat(radius * cos(angle))
                    let yOffset = CGFloat(radius * sin(angle))
                    
                    
                    Text("\(array[index].val)")
                    // Text의 방향을 잡는 코드
                        .rotationEffect(Angle(radians: angle))
                    //                        .rotationEffect(Angle(degrees: -degree))
                        .offset(x: xOffset, y: yOffset )
                        .font(Font.system(chosenIndex == index ? .title : .body, design: .monospaced))
                }
            }
            .rotationEffect(Angle(degrees: degree))
            .gesture(drag)
            .onAppear {
                radius = circleSize/2 - 10 // 10은 zstack에서 각 요소에 얼마나 안쪽으로 패딩을 줄 것인지
            }
            // MARK: WHEEL STACK - END
        }
        .frame(width: circleSize, height: circleSize)
//        .background(.red)
    }
    
    func moveWheel() {
        withAnimation(.spring()) {
            if direction == .down {
                degree += Double(360/array.count)
                
                if chosenIndex == 0 {
                    // 0번 인덱스에서 마지막 인덱스로 설정
                    chosenIndex = array.count-1
                } else {
                    chosenIndex -= 1
                }
            } else {
                degree -= Double(360/array.count)
                
                if chosenIndex == array.count-1 {
                    chosenIndex = 0
                } else {
                    chosenIndex += 1
                }
            }
        }
    }

}


#Preview {
    WheelView(array: [MyValue(val: "1"), MyValue(val: "2"), MyValue(val: "3"), MyValue(val: "4"), MyValue(val: "5"), MyValue(val: "6"), MyValue(val: "7"), MyValue(val: "8"), MyValue(val: "9"), MyValue(val: "10")], circleSize: 200)
}
