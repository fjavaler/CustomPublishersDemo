//
//  ContentView.swift
//  CustomPublishersAndSubscribersInCombineDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: Properties
  @StateObject var vm = ContentViewModel()
  
  // MARK: Body
  var body: some View {
    VStack {
      Text("\(vm.count)")
        .font(.largeTitle)
      
      TextField("Type something here...", text: $vm.textFieldText)
        .padding(.leading)
        .frame(height: 55)
        .font(.headline)
        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
        .cornerRadius(10)
        .overlay(
          ZStack {
            Image(systemName: "xmark")
              .foregroundColor(.red)
              .opacity(
                vm.textFieldText.count < 1 ? 0.0 :
                vm.textIsValid ? 0.0 : 1.0)
            
            Image(systemName: "checkmark")
              .foregroundColor(.green)
              .opacity(vm.textIsValid ? 1.0 : 0.0)
          }
          .font(.headline)
          .padding(.trailing)
          
          , alignment: .trailing
        )
      
      Button(action: {
        
      }, label: {
        Text("Submit".uppercased())
          .font(.headline)
          .foregroundColor(.white)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .cornerRadius(10)
          .opacity(vm.showButton ? 1.0 : 0.5)
      })
      .disabled(!vm.showButton)
      
    }
    .padding()
  }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
