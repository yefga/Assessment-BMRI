//
//  UIView.swift
//  AssignmentKit
//
//  Created by yepz on 05/03/23.
//

import Foundation
import UIKit

public struct AssociatedKeys {
    static var actionState: UInt8 = 0
}

public typealias ActionTap = () -> Void

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            if !self.subviews.contains($0) {
                self.addSubview($0)
            }
        }
    }
    
    var onClick: ActionTap? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.actionState) as? ActionTap else {
                return nil
            }
            return value
        }
        set {
            if newValue == nil {
                objc_removeAssociatedObjects(self)
            } else {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.actionState,
                    newValue,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                
                self.tapWithAnimation()
            }
        }
    }
    
    
    func tapWithAnimation() {
        self.isUserInteractionEnabled = true
        self.gestureRecognizers?.removeAll()
        //        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(viewLongTap(_:)))
        //        longTap.minimumPressDuration = 0.035
        //        longTap.cancelsTouchesInView = true
        //        longTap.delaysTouchesBegan = true
        //        longTap.delegate = self
        let longTap = UITapGestureRecognizer(target: self, action: #selector(viewLongTap(_:)))
        self.addGestureRecognizer(longTap)
    }
    
    @objc
    func viewLongTap(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .ended {
            animateView(alpha: 0.3)
            return
        } else if gesture.state == .ended {
            let touchLocation = gesture.location(in: self)
            if self.bounds.contains(touchLocation) {
                animateView(alpha: 1)
                onClick?()
                return
            }
        }
        animateView(alpha: 1)
    }
    
    fileprivate func animateView(alpha: CGFloat) {
        UIView.transition(with: self, duration: 0.3,
                          options: .transitionCrossDissolve, animations: {
            self.subviews.forEach { subView in
                subView.alpha = alpha
            }
        })
    }
}
