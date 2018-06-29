//
//  PingTransition.m
//  DAD
//
//  Created by 陆久银 on 2018/6/29.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "PingTransition.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@interface PingTransition()<CAAnimationDelegate>
@property (nonatomic, strong) id transitionContext;
@end

@implementation PingTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    BlueViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YellowViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIButton *circleBtn = fromVC.circleBtn;
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:circleBtn.frame];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];

    
    CGPoint finalPoint = CGPointMake(circleBtn.center.x-0, circleBtn.center.y - CGRectGetHeight(toVC.view.bounds));
    CGFloat radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y);
    
    CGRect final = CGRectInset(circleBtn.frame, -radius, -radius);
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:final];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}
@end
