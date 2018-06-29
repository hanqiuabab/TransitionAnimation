//
//  CollectionViewController.h
//  DAD
//
//  Created by 陆久银 on 2018/6/28.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController

@property (nonatomic,strong) NSIndexPath *selectedIndex;
@property (nonatomic,assign) CGRect finalRect;

@end
