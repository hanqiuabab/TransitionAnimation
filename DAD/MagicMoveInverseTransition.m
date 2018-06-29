//
//  MagicMoveInverseTransition.m
//  DAD
//
//  Created by 陆久银 on 2018/6/29.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "MagicMoveInverseTransition.h"
#import "ThirdViewController.h"
#import "CollectionViewController.h"
#import "CollectionViewCell.h"

@implementation MagicMoveInverseTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    ThirdViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapView.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    fromVC.imageView.hidden = YES;
    
    CollectionViewCell *cell = (CollectionViewCell*)[toVC.collectionView cellForItemAtIndexPath:toVC.selectedIndex];
    cell.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        snapView.frame = toVC.finalRect;
    }completion:^(BOOL finished) {
        [snapView removeFromSuperview];
        fromVC.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

@end
