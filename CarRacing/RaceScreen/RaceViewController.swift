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
    var barriers: [UIImageView] = []
    var scoreLabel: UILabel!
    
    var score = 0
    var opponentCarTimer: Timer?
    var barrierTimer: Timer?
    var markingLineTimer: Timer?
    
    var displayLink: CADisplayLink?
    
    // MARK: - lifecycle funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGame()
        setUpUI()
        setUpMarkingLine()
        setUpTimers()
    }
    
    // MARK: - private methods
    
    private func setUpGame() {
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
        
        playerCar = UIImageView(frame: CGRect(x: .xPlayerCar,
                                              y: .yPlayerCar,
                                              width: .playerCarWidth,
                                              height: .playerCarHeight)
        )
        playerCar.image = UIImage(named: .playerCarRed)
        view.addSubview(playerCar)
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
    
    private func setUpMarkingLine() {
        markingLineLong = UIImageView(frame: CGRect(x: .xMarkingLineLong,
                                                    y: .yMarkingLineLong,
                                                    width: .markingLineLongWidth,
                                                    height: .markingLineLongHeight)
        )
        markingLineLong.image = UIImage(named: .markingLineLong)
        view.addSubview(markingLineLong)
                
        UIView.animate(withDuration: .slowly,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: { [self] in
            markingLineLong.frame.origin.y = self.view.frame.height
        },
                       completion: nil)
    }
    
    private func setUpTimers() {
        barrierTimer = Timer.scheduledTimer(timeInterval: .quickly,
                                     target: self,
                                     selector: #selector(addBarriers),
                                     userInfo: nil,
                                     repeats: true
        )
        
        opponentCarTimer = Timer.scheduledTimer(timeInterval: .quickly,
                                     target: self,
                                     selector: #selector(addOpponentCar),
                                     userInfo: nil,
                                     repeats: true
        )
        
        markingLineTimer = Timer.scheduledTimer(timeInterval: .current,
                                     target: self,
                                     selector: #selector(animateMarkingLine),
                                     userInfo: nil,
                                     repeats: true
        )
        
    }
    
    private func createDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(checkCollision))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    private func endGame() {
        scoreLabel.isHidden = true
        opponentCarTimer?.invalidate()
        barrierTimer?.invalidate()
        markingLineTimer?.invalidate()
        
        let alertController = UIAlertController(title: "Game Over", message: "Your score is \(score)", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: false)
        }
        let playAgainAction = UIAlertAction(title: "Play again", style: .default) { _ in
            self.restartGame()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(playAgainAction)

        present(alertController, animated: true, completion: nil)
    }
    
    private func restartGame() {
        for car in opponentCars {
            car.removeFromSuperview()
        }
        opponentCars.removeAll()
        score = 0
        scoreLabel.text = "Score: 0"
        scoreLabel.isHidden = false
        playerCar.frame.origin.x = .xPlayerCar
        setUpTimers()
    }
    
    // MARK: - target actions
    
    @objc func addBarriers() {
        let leftBarrier = UIImageView(frame: CGRect(x: .xLeftBarrier,
                                                y: 0,
                                                width: .barrierWidth,
                                                height: .barrierHeight)
        )
        
        let rightBarrier = UIImageView(frame: CGRect(x: .xRightBarrier,
                                                     y: 0,
                                                     width: .barrierWidth,
                                                     height: .barrierHeight)
        )
        
        guard let barrierType: String = [
            .tree,
            .stone
        ].randomElement() else { return }
        
        leftBarrier.image = UIImage(named: barrierType)
        view.addSubview(leftBarrier)
        barriers.append(leftBarrier)
        
        guard let barrierType: String = [
            .tree,
            .stone
        ].randomElement() else { return }
        
        rightBarrier.image = UIImage(named: barrierType)
        view.addSubview(rightBarrier)
        barriers.append(rightBarrier)
        
        
        UIView.animate(withDuration: .slowly,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: { [self] in
            leftBarrier.frame.origin.y = self.view.frame.height
            rightBarrier.frame.origin.y = self.view.frame.height
        },
                       completion: nil)
    }
    
    @objc func animateMarkingLine() {
        let markingLine = UIImageView(frame: CGRect(x: .xMarkingLine,
                                                    y: .yMarkingLine,
                                                    width: .markingLineWidth,
                                                    height: .markingLineHeight)
        )
        markingLine.image = UIImage(named: .markingLine)
        view.addSubview(markingLine)
        
        UIView.animate(withDuration: .slowly,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: { [self] in
            markingLine.frame.origin.y = self.view.frame.height
        },
                       completion: nil)
    }
    
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
        
        UIView.animate(withDuration: .quickly,
                       delay: 0.0,
                       options: .curveLinear,
                       animations: { [self] in
            opponentCar.frame.origin.y = self.view.frame.height
            createDisplayLink()
            
        }, completion: { _ in
            self.score += 1
            self.scoreLabel.text = "Score: \(self.score)"
            opponentCar.removeFromSuperview()
            self.opponentCars.remove(at: self.opponentCars.firstIndex(of: opponentCar)!)
        })
    }
    
    @objc func checkCollision() {
        for car in opponentCars {
            if playerCar.layer.presentation()!.frame.intersects(car.layer.presentation()!.frame) {
                endGame()
            }
        }
        
        for barrier in barriers {
            if playerCar.layer.presentation()!.frame.intersects(barrier.layer.presentation()!.frame) {
                endGame()
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
            }, 
                           completion: nil)
        }
    }
    
    @objc func movePlayerCarRight() {        
        if playerCar.frame.origin.x < rightRoadside.frame.origin.x {
            UIView.animate(withDuration: .standard,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: { [self] in
                playerCar.frame.origin.x += .sideInterval
            }, 
                           completion: nil)
        }
    }
}
