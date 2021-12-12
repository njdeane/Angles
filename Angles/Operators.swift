//
//  Operators.swift
//  Angles
//
//  Created by Nic Deane on 12/12/21.
//

import SwiftUI

func + (left: CGSize, right: CGSize) -> CGSize {
  CGSize(
    width: left.width + right.width,
    height: left.height + right.height)
}
