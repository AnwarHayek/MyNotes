//
//  Progress.swift
//  MyNotes
//
//  Created by Anwar Alhayek on 21/08/2023.
//

import Foundation
import UIKit

class Progress {

    static let window = UIApplication.shared.currentWindow

    static var color: UIColor = "#6A90F2"._color

    static func showLoader() {

        DispatchQueue.main.async {
            if let _window = self.window {
                let loaderView = LoaderView()
                loaderView.tag = 101
                loaderView.center = _window.center
                _window.addSubview(loaderView)
                loaderView.alpha = 0
                UIView.transition(with: loaderView, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    loaderView.alpha = 1.0
                }, completion: nil)
            }
        }
    }

    static func dismiss() {
        DispatchQueue.main.async {
            if let _window = self.window {
                if let removable = _window.viewWithTag(101) {
                    UIView.transition(with: removable.superview ?? UIView(), duration: 0.1, options: .transitionCrossDissolve, animations: {
                        removable.alpha = 0.0
                    }, completion: { _ in
                        removable.removeFromSuperview()
                    })
                }
            }
        }
    }

    static func LoaderView() -> UIView {

        guard let window = self.window else { return UIView() }

        let width: CGFloat = 44

        let backgroundView = UIView(frame: window.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        let progressViewBackground = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        progressViewBackground.layer.cornerRadius = 10
        progressViewBackground.backgroundColor = UIColor.white


        progressViewBackground.center = backgroundView.center
        backgroundView.addSubview(progressViewBackground)

        let progressView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))

        progressView.center = backgroundView.center
        backgroundView.addSubview(progressView)


        let spacing: CGFloat = 3
        let radius = (width - 4 * spacing) / 3.5
        let radiusX = (width - radius) / 2

        let duration = 1.0
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12, 0]

        let animationScale = CAKeyframeAnimation(keyPath: "transform.scale")
        animationScale.keyTimes = [0, 0.5, 1]
        animationScale.values = [1, 0.4, 1]
        animationScale.duration = duration

        let animationOpacity = CAKeyframeAnimation(keyPath: "opacity")
        animationOpacity.keyTimes = [0, 0.5, 1]
        animationOpacity.values = [1, 0.3, 1]
        animationOpacity.duration = duration

        let animation = CAAnimationGroup()
        animation.animations = [animationScale, animationOpacity]
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        let path = UIBezierPath(arcCenter: CGPoint(x: radius / 2, y: radius / 2), radius: radius / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: false)

        for i in 0..<8 {
            let angle = .pi / 4 * CGFloat(i)

            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.fillColor = self.color.cgColor//UIColor.red.cgColor
            layer.backgroundColor = nil
            layer.frame = CGRect(x: radiusX * (cos(angle) + 1), y: radiusX * (sin(angle) + 1), width: radius, height: radius)

            animation.beginTime = beginTime - beginTimes[i]

            layer.add(animation, forKey: "animation")
            progressView.layer.addSublayer(layer)
        }
        return backgroundView
    }
}
