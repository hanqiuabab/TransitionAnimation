//
//  MagicMoveTransition.m
//  DAD
//
//  Created by 陆久银 on 2018/6/28.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "ThirdViewController.h"

@implementation MagicMoveTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    CollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ThirdViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    CollectionViewCell *cell = (CollectionViewCell*)[fromVC.collectionView cellForItemAtIndexPath:[fromVC.collectionView indexPathsForSelectedItems].firstObject];
    fromVC.selectedIndex = [fromVC.collectionView indexPathsForSelectedItems].firstObject;
    UIView *snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame =fromVC.finalRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;

    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1;
        snapShotView.frame = [containerView convertRect:toVC.imageView.frame toView:toVC.view];
    }completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        toVC.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
