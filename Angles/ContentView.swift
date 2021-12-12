//
//  ContentView.swift
//  Angles
//
//  Created by Nic Deane on 12/12/21.
//

import SwiftUI

struct ContentView: View {
  
  @State private var d = Double(0)
  @State private var x = CGFloat(0)
  @State private var y = CGFloat(1)
  @State private var z = CGFloat(0)
  
  @State private var xx = Double(0.5)
  @State private var yy = CGFloat(0.5)
  @State private var pp = CGFloat(0.5)
  
  @State private var transform = Transform()
  
  //Drag
  @State private var previousOffset: CGSize = .zero
  
  //Rotate
  @State private var previousRotation: Angle = .zero
  
  //Scale
  @State private var scale: CGFloat = 1.0

  
  
  var body: some View {
    let scaleGesture = MagnificationGesture()
      .onChanged { scale in
        self.scale = scale
      }
      .onEnded { scale in
        transform.size.width *= scale
        transform.size.height *= scale
        self.scale = 1.0
      }
    
    let rotationGesture = RotationGesture()
      .onChanged { rotation in
        transform.rotation += rotation - previousRotation
        previousRotation = rotation
      }
      .onEnded { _ in
        previousRotation = .zero
      }
    
    let dragGesture = DragGesture()
      .onChanged { value in
        transform.offset = value.translation + previousOffset
      }
      .onEnded { _ in
        previousOffset = transform.offset
      }
    
    
    VStack {
      
      Spacer()
      
      ZStack {
        Image("188B")
          .resizable()
          .scaledToFit()
        Image("art1")
          .resizable()
          .scaledToFill()
          .offset(transform.offset)
          .rotationEffect(transform.rotation)
          .scaleEffect(scale)
          .gesture(dragGesture)
          .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
          .rotation3DEffect(.degrees(d), axis: (x: x, y: y, z: z), anchor:  UnitPoint.init(x: xx, y: yy), anchorZ: 0, perspective: pp)
          .frame(width: transform.size.width, height: transform.size.height)
          .shadow(color: .black, radius: 4, x: 2, y: 2)
          
      }
      Spacer()
      
      VStack {
        HStack {
          Text("D")
          Slider(value: $d, in: 0...360, step: 1)
          Text("\(d)")
        }
        
        HStack {
          Text("X")
          Slider(value: $x, in: -1...1, step: 0.01)
          Text("\(x)")
        }
        
        HStack {
          Text("Y")
          Slider(value: $y, in: -1...1, step: 0.01)
          Text("\(y)")
        }
        
        HStack {
          Text("Z")
          Slider(value: $z, in: -1...1, step: 0.01)
          Text("\(z)")
        }
        
        HStack {
          Text("XX")
          Slider(value: $xx, in: -1...1, step: 0.01)
          Text("\(xx)")
        }
        
        HStack {
          Text("YY")
          Slider(value: $yy, in: -1...1, step: 0.01)
          Text("\(yy)")
        }
        
        HStack {
          Text("PP")
          Slider(value: $pp, in: -1...1, step: 0.01)
          Text("\(pp)")
        }
      }
      .padding()
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
