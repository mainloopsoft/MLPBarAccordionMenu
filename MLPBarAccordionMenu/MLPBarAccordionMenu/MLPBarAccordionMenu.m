//
//  MLPBarAccordionMenu.m
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPBarAccordionMenu.h"
#import "MLPBarAccordionCell.h"
#import "MLPMenuItem.h"
#import <QuartzCore/QuartzCore.h>

#define kCellSize 70
#define kCellPad 4

static NSString *cellIdentifier = @"MLPBarAccordionCell";

@implementation MLPBarAccordionMenu


- (id)init
{
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(kCellSize, kCellSize)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:aFlowLayout];
    if (self) {
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"MLPBarAccordionCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    }
    
    self.clipsToBounds = NO;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0,3);
    self.layer.shadowOpacity = 0.8;
    
    return self;
}

- (id)initWithDelegate:(id<UICollectionViewDelegate>)delegate
{
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    
    return self;
}

- (id)initWithItems:(NSArray*)menuItems
{
    self = [self init];
    if (self) {
        self.menuItems = menuItems;
    }
    
    return self;
}

- (void)toggleInView:(UIView*)view
{
    if (self.superview != nil) {
        [self hideView:view];
    }else{
        [self showInView:view];
    }
}

- (void)showInView:(UIView*)topView
{
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSAssert([viewController isKindOfClass:[UINavigationController class]], @"You must add a navigation controller");
    
    UINavigationController *navController = (UINavigationController*)viewController;
    UINavigationBar *navBar = navController.navigationBar;
    NSInteger navBarHeight = navBar.frame.size.height;
    NSInteger rows = (self.menuItems.count * kCellSize)%4;
    NSInteger height = ((rows == 0 ? 1 : rows)* kCellSize) + (rows * kCellPad);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    if (![UIApplication sharedApplication].statusBarHidden){
        NSInteger statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        navBarHeight += statusBarHeight;
    }
    
    self.frame = CGRectMake(0, -height + navBarHeight, screenWidth, height);
    [navController.view insertSubview:self belowSubview:navController.navigationBar];
    
    
    //Animate popup
    [UIView animateWithDuration:0.3
                     animations:^{
                         topView.frame = CGRectApplyAffineTransform(topView.frame, CGAffineTransformMakeTranslation(0, height));
                         self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(0, height));
                         
                     }
                     completion:^(BOOL finished){
                         if(finished){
                         }
                     }];
}

- (void)hideView:(UIView*)topView
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSAssert([viewController isKindOfClass:[UINavigationController class]], @"You must add a navigation controller");
    
    UINavigationController *navController = (UINavigationController*)viewController;
    UINavigationBar *navBar = navController.navigationBar;
    NSInteger navBarHeight = navBar.frame.size.height;
    NSInteger rows = (self.menuItems.count * kCellSize)%4;
    NSInteger height = ((rows == 0 ? 1 : rows)* kCellSize) + (rows * kCellPad);
    
    if (![UIApplication sharedApplication].statusBarHidden){
        NSInteger statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        navBarHeight += statusBarHeight;
    }
    
    //Animate popup
    [UIView animateWithDuration:0.3
                     animations:^{
                         topView.frame = CGRectApplyAffineTransform(topView.frame, CGAffineTransformMakeTranslation(0, -height));
                         self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(0, -height));
                         
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             [self removeFromSuperview];
                         }
                     }];
}


#pragma mark - DataSource Methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLPBarAccordionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    MLPMenuItem *item = [self.menuItems objectAtIndex:indexPath.row];
    cell.iconImageView.image = item.icon;
    cell.titleLabel.text = item.title;
    
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCellSize, kCellSize);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCellPad, kCellPad, kCellPad, kCellPad);
}

@end
