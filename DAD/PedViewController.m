//
//  PedViewController.m
//  DAD
//
//  Created by 陆久银 on 2018/6/29.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "PedViewController.h"
#import "CustomTransition.h"
#import "CustomPresentation.h"

@interface PedViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation PedViewController{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
}




-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
        
    }
    return self;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
}

-(void)panGes:(UIPanGestureRecognizer *)gesture{
    CGFloat yOffset = [gesture translationInView:self.view].y;
    percent =  yOffset / 1800;
    //    percent = MAX(0, MIN(1, percent));
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        //这句必须加上！！
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded){
        [percentDrivenInteractiveTransition finishInteractiveTransition];
        //        if (percent > 0.06) {
        //
        //
        //        }else{
        
        //            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        
        //        }
        //这句也必须加上！！
        percentDrivenInteractiveTransition = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - <UIViewControllerTransitioningDelegate>
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    CustomPresentation *presentation = [[CustomPresentation alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CustomTransition * present = [[CustomTransition alloc]initWithBool:YES];
    return present;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (dismissed) {
        CustomTransition * present = [[CustomTransition alloc]initWithBool:NO];
        return present;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    if (animator) {
        return percentDrivenInteractiveTransition;
    }else{
        return nil;
    }
}

- (IBAction)dismissAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
