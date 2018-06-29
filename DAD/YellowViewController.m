//
//  YellowViewController.m
//  DAD
//
//  Created by 陆久银 on 2018/6/29.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "YellowViewController.h"
#import "PingInverseTransition.h"
#import "BlueViewController.h"
@interface YellowViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percenterTransition;
@end

@implementation YellowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(progress, 0.0));
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percenterTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.percenterTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if(progress>0.5){
                [self.percenterTransition finishInteractiveTransition];
            }else{
                [self.percenterTransition cancelInteractiveTransition];
            }
            self.percenterTransition = nil;
        }
            break;
        default:
            break;
    }
}

- (IBAction)disMiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.percenterTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [PingInverseTransition new];
    }else {
        return nil;
    }
}
@end
