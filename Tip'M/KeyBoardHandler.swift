//
//  KeyBoardHandler.swift
//  Tip'M
//
//  Created by Senuda Ratnayake on 9/28/22.
//

import Combine
import SwiftUI

final class KeyBoardHandler: ObservableObject{
    @Published private(set) var keyboardHeight: CGFloat = 0 //padding will change accordingly
    
    private var cancellable: AnyCancellable?
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap{ ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
        }
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map{ _ in CGFloat.zero }
        
    init(){
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on:DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
    
    
}