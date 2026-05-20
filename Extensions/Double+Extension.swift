//
//  Double+Extension.swift
//  ComponentRecognitionTest.1
//
//  Created by Reece Clem on 3/21/25.
//
import math_h

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
