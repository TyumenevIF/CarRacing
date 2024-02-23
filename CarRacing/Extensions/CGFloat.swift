//
//  CGFloat.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 18.02.2024.
//

import Foundation
import UIKit

extension CGFloat {
    static let xLeftRoadside: CGFloat = 0
    static let yLeftRoadside: CGFloat = 0
    static let leftRoadsideWidth = UIScreen.main.bounds.width / 4
    static let leftRoadsideHeight = UIScreen.main.bounds.height
    
    static let xRoad = UIScreen.main.bounds.width / 4
    static let yRoad: CGFloat = 0
    static let roadWidth = UIScreen.main.bounds.width / 2
    static let roadHeight = UIScreen.main.bounds.height
    
    static let xRightRoadside = UIScreen.main.bounds.width * 3 / 4
    static let yRightRoadside: CGFloat = 0
    static let rightRoadsideWidth = UIScreen.main.bounds.width / 4
    static let rightRoadsideHeight = UIScreen.main.bounds.height
    
    static let xMarkingLine = UIScreen.main.bounds.width / 2
    static let yMarkingLine: CGFloat = -markingLineHeight / 2
    static let markingLineWidth: CGFloat = 1
    static let markingLineHeight = playerCarHeight / 2
    
    static let xMarkingLineLong = xMarkingLine
    static let yMarkingLineLong: CGFloat = 0
    static let markingLineLongWidth: CGFloat = 1
    static let markingLineLongHeight = UIScreen.main.bounds.height
    
    static let xPlayerCar = UIScreen.main.bounds.width / 2 + playerCarWidth / 2
    static let yPlayerCar = UIScreen.main.bounds.height - 2 * playerCarHeight
    static let playerCarWidth = roadWidth / 4
    static let playerCarHeight = playerCarWidth * 2
    
    static let xOpponentCar = UIScreen.main.bounds.width / 2 + opponentCarWidth / 2
    static let yOpponentCar = UIScreen.main.bounds.height - 2 * opponentCarHeight
    static let opponentCarWidth = roadWidth / 4
    static let opponentCarHeight = opponentCarWidth * 2
    static let opponentCarLeftPosition = xRoad + opponentCarWidth / 2
    static let opponentCarRightPosition = xRoad + roadWidth / 2 + opponentCarWidth / 2
    
    static let xLeftBarrier = barrierWidth / 3
    static let xRightBarrier = xRightRoadside + barrierWidth * 2 / 3
    static let barrierWidth = roadWidth / 4
    static let barrierHeight = barrierWidth
    
    static let startViewButtonCornerRadius: CGFloat = 10
    static let leftRightButtonWidth: CGFloat = 60
    static let leftRightButtonHeight: CGFloat = 60
    static let leftRightButtonCornerRadius: CGFloat = 10
    static let trailingOffsetRightButton: CGFloat = 20
    
    static let xLeftButton: CGFloat = 20
    static let xRightButton: CGFloat = UIScreen.main.bounds.width - leftRightButtonWidth - trailingOffsetRightButton
    static let yButton = UIScreen.main.bounds.height - bottomOffsetButton
    static let bottomOffsetButton: CGFloat = 90
    
    static let sideInterval = roadWidth / 2
}
