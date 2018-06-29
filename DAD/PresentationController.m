
//
//  PresentationController.m
//  DAD
//
//  Created by 陆久银 on 2018/6/29.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "PresentationController.h"

@interface PresentationController()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIView *contview;

@property (nonatomic, strong) id transitionCoordinator;

@end

@implementation PresentationController

- (void)presentationTransitionWillBegin {
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [self.bgView insertSubview:self.blurView atIndex:0];
    
    self.contview = self.containerView;
    [self.contview addSubview:self.presentingViewController.view];
    [self.contview addSubview:self.bgView];
    [self.contview addSubview:self.presentedView];
    
    self.bgView.alpha = 0.0;
    self.transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0.7;
        self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, 0.92, 0.92);
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if(!completed){
        [self.bgView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    self.transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if(completed){
        [self.bgView removeFromSuperview];
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.presentingViewController.view];
}
@end
