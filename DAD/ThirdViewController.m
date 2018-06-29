//
//  ThirdViewController.m
//  DAD
//
//  Created by 陆久银 on 2018/6/28.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "ThirdViewController.h"
#import "MagicMoveInverseTransition.h"
#import "CollectionViewController.h"
@interface ThirdViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    UIScreenEdgePanGestureRecognizer *edgePanGuesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePanGuesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGuesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    if(recognizer.state == UIGestureRecognizerStateBegan){
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        if(progress > 0.5){
            [self.percentDrivenTransition finishInteractiveTransition];
        }else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if([animationController isKindOfClass:[MagicMoveInverseTransition class]]){
        return self.percentDrivenTransition;
    }else {
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if([toVC isKindOfClass:[CollectionViewController class]]){
        MagicMoveInverseTransition *inverseTransition = [[MagicMoveInverseTransition alloc] init];
        return inverseTransition;
    }else {
        return nil;
    }
}

@end
