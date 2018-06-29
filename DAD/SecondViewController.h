//
//  SecondViewController.h
//  DAD
//
//  Created by 陆久银 on 2018/6/28.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondViewController;

@protocol PresentedVCDelegate <NSObject>

-(void)didPresentedVC:(SecondViewController *)viewcontroller;

@end

@interface SecondViewController : UIViewController
@property(nonatomic,weak) id<PresentedVCDelegate>delegate;

@end
