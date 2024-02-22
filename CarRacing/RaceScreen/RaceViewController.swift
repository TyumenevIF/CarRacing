//
//  RaceViewController.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 10.02.2024.
//

import UIKit

final class RaceViewController: UIViewController {
    
    // MARK: - let/var
    
    var leftRoadside: UIImageView!
    var road: UIImageView!
    var rightRoadside: UIImageView!
    var markingLineLong: UIImageView!
    var playerCar: UIImageView!
    var opponentCars = [UIImageView]()
    var trees: [UIImageView] = []
    var stones: [UIImageView] = []
    var scoreLabel: UILabel!
    
    var score = 0
    var timeIntervalTimer: Timer?
    var animationDurationTimer: Timer?
    
    // MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
        setUpUI()
    }
    
    // MARK: - private methods
    
    private func setupGame() {
        leftRoadside = UIImageView(frame: CGRect(x: .xLeftRoadside,
                                                 y: .yLeftRoadside,
                                                 width: .leftRoadsideWidth,
                                                 height: .leftRoadsideHeight)
        )
        leftRoadside.image = UIImage(named: .leftRoadside_1)
        view.addSubview(leftRoadside)
        
        road = UIImageView(frame: CGRect(x: .xRoad,
                                         y: .yRoad,
                                         width: .roadWidth,
                                         height: .roadHeight)
        )
        road.image = .road1
        view.addSubview(road)
        
        rightRoadside = UIImageView(frame: CGRect(x: .xRightRoadside,
                                                  y: .yRightRoadside,
                                                  width: .rightRoadsideWidth,
                                                  height: .rightRoadsideHeight)
        )
        rightRoadside.image = UIImage(named: .rightRoadside_1)
        view.addSubview(rightRoadside)
        
        markingLineLong = UIImageView(frame: CGRect(x: .xMarkingLineLong,
                                                    y: .yMarkingLineLong,
                                                    width: .markingLineLongWidth,
                                                    height: .markingLineLongHeight)
        )
        markingLineLong.image = UIImage(named: .markingLineLong)
        view.addSubview(markingLineLong)
        
        playerCar = UIImageView(frame: CGRect(x: .xPlayerCar,
                                              y: .yPlayerCar,
                                              width: .playerCarWidth,
                                              height: .playerCarHeight)
        )
        playerCar.image = UIImage(named: .playerCarRed)
        view.addSubview(playerCar)
        
        let treeImage = UIImage(named: .tree)
        for i in 0..<4 {
            let tree = UIImageView(image: treeImage)
            tree.frame = CGRect(x: .xTree,
                                y: .yTree + CGFloat(i) * 150,
                                width: .treeWidth,
                                height: .treeHeight
            )
            trees.append(tree)
            view.addSubview(tree)
        }
        
        let stoneImage = UIImage(named: .stone)
        for i in 0..<4 {
            let stone = UIImageView(image: stoneImage)
            stone.frame = CGRect(x: .xStone,
                                 y: .yStone + CGFloat(i) * 150,
                                 width: .stoneWidth,
                                 height: .stoneHeight
            )
            stones.append(stone)
            view.addSubview(stone)
        }
        
        timeIntervalTimer = Timer.scheduledTimer(timeInterval: .normal,
                                     target: self,
                                     selector: #selector(addOpponentCar),
                                     userInfo: nil,
                                     repeats: true
        )
    }
    
    private func setUpUI() {
        let leftButton = UIButton(frame: CGRect(x: .xLeftButton,
                                                y: .yButton,
                                                width: .leftRightButtonWidth,
                                                height: .leftRightButtonHeight)
        )
        leftButton.setTitle("Left", for: .normal)
        leftButton.contentHorizontalAlignment = .center
        leftButton.backgroundColor = .orange
        leftButton.layer.cornerRadius = .leftRightButtonCornerRadius
        leftButton.addTarget(self, action: #selector(movePlayerCarLeft), for: .touchUpInside)
        view.addSubview(leftButton)
        
        let rightButton = UIButton(frame: CGRect(x: .xRightButton,
                                                 y: .yButton,
                                                 width: .leftRightButtonWidth,
                                                 height: .leftRightButtonHeight)
        )
        rightButton.setTitle("Right", for: .normal)
        rightButton.contentHorizontalAlignment = .center
        rightButton.backgroundColor = .orange
        rightButton.layer.cornerRadius = .leftRightButtonCornerRadius
        rightButton.addTarget(self, action: #selector(movePlayerCarRight), for: .touchUpInside)
        view.addSubview(rightButton)
        
        scoreLabel = UILabel(frame: CGRect(x: view.frame.width - 100, y: 40, width: 100, height: 50))
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
    }
    
    private func checkCollision() {
        for car in opponentCars {
            if playerCar.frame.intersects(car.frame) {
                endGame()
                print("Opponent car frame: \(car.frame)")
                print("Player car frame: \(playerCar.frame)")
            }
        }
    }
    
    private func endGame() {
        timeIntervalTimer?.invalidate()
        animationDurationTimer?.invalidate()
        print("Игра окончена! Спасибо за игру!")
        
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.restartGame()
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func restartGame() {
        for car in opponentCars {
            car.removeFromSuperview()
        }
        
        opponentCars.removeAll()
        
        score = 0
        scoreLabel.text = "Score: 0"
        
        timeIntervalTimer = Timer.scheduledTimer(timeInterval: .normal,
                                     target: self,
                                     selector: #selector(addOpponentCar),
                                     userInfo: nil,
                                     repeats: true
        )
    }
    
    // MARK: - target actions
    
    @objc func addOpponentCar() {
        let leftPosition: CGFloat = .opponentCarLeftPosition
        let rightPosition: CGFloat = .opponentCarRightPosition
        guard let opponentCarPosition: CGFloat = [leftPosition, rightPosition].randomElement() else { return }
        let opponentCar = UIImageView(frame: CGRect(x: opponentCarPosition,
                                                    y: 0,
                                                    width: .opponentCarWidth,
                                                    height: .opponentCarHeight)
        )
        
        guard let opponentCarType: String = [
            .opponentCar911,
            .opponentCarBlue,
            .opponentCarGreen,
            .opponentCarOrange,
            .opponentCarRed,
            .truckGreen,
            .truckGreen
        ].randomElement() else { return }
        opponentCar.image = UIImage(named: opponentCarType)
        view.addSubview(opponentCar)
        opponentCars.append(opponentCar)
        
        animationDurationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            opponentCar.frame.origin.y += 50
            
            self.checkCollision()
            
            if let index = self.opponentCars.firstIndex(of: opponentCar), opponentCar.frame.origin.y > self.playerCar.frame.maxY {
                self.opponentCars.remove(at: index)
                self.score += 1
                self.scoreLabel.text = "Score: \(self.score)"
                opponentCar.removeFromSuperview()
                timer.invalidate()
            }
        }
    }
    
    @objc func movePlayerCarLeft() {
        if road.frame.origin.x < playerCar.frame.origin.x {
            UIView.animate(withDuration: .standard,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: { [self] in
                playerCar.frame.origin.x -= .sideInterval
            }, completion: nil)
        }
    }
    
    @objc func movePlayerCarRight() {        
        if playerCar.frame.origin.x < rightRoadside.frame.origin.x {
            UIView.animate(withDuration: .standard,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: { [self] in
                playerCar.frame.origin.x += .sideInterval
            }, completion: nil)
        }
    }
}
