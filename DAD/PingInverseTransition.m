//
//  PingInverseTransition.m
//  DAD
//
//  Created by 陆久银 on 2018/6/29.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "PingInverseTransition.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@interface PingInverseTransition()<CAAnimationDelegate>
@property (nonatomic, strong) id transitionContext;
@end

@implementation PingInverseTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    YellowViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BlueViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIButton *circleBtn = toVC.circleBtn;
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:circleBtn.frame];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    CGPoint finalPoint = CGPointMake(circleBtn.center.x-0, circleBtn.center.y - CGRectGetHeight(toVC.view.bounds));
    CGFloat radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y);
    
    CGRect final = CGRectInset(circleBtn.frame, -radius, -radius);
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:final];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskStartBP.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskStartBP.CGPath);
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [maskLayer addAnimation:maskLayerAnimation forKey:@"pingInvert"];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}
@end
