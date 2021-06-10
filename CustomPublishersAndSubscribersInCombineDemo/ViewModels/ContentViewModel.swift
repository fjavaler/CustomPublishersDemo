//
//  ContentViewModel.swift
//  CustomPublishersAndSubscribersInCombineDemo
//
//  Created by Fred Javalera on 6/10/21.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
  
  // MARK: Properties
  @Published var count: Int = 0
  var cancellables = Set<AnyCancellable>()
  
  @Published var textFieldText: String = ""
  @Published var textIsValid: Bool = false
  
  @Published var showButton: Bool = false
  
  init() {
    setUpTimer()
    addTextFieldSubscriber()
    addButtonSubscriber()
  }
  
  // MARK: Methods
  
  func addTextFieldSubscriber() {
    $textFieldText
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map { text -> Bool in
        if text.count > 3 {
          return true
        }
        return false
      }
//      .assign(to: \.textIsValid, on: self)
      .sink(receiveValue: { [weak self] isValid in
        self?.textIsValid = isValid
      })
      .store(in: &cancellables)
  }
  
  func setUpTimer() {
    Timer
      .publish(every: 1.0, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.count += 1
        
//        if self.count >= 10 {
//          for item in self.cancellables {
//            item.cancel()
//          }
//        }
        
      }
      .store(in: &cancellables)
  }
  
  func addButtonSubscriber() {
    $textIsValid
      .combineLatest($count)
      .sink { [weak self] isValid, count in
        guard let self = self else { return }
        if isValid && count >= 10 {
          self.showButton = true
        } else {
          self.showButton = false
        }
      }
      .store(in: &cancellables)
  }
  
}
