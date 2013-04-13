//
//  MLPBarAccordionMenu.h
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPBarAccordionMenuItem : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *title;

@end

typedef void (^MLPBarAccordionMenuBlock)(NSIndexPath* indexPath);

@interface MLPBarAccordionMenu : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *menuItems;
@property (readwrite, nonatomic, copy) MLPBarAccordionMenuBlock selectedBlock;

- (id)initWithItems:(NSArray*)menuItems;

- (void)toggleBetweenNavigationBar:(UINavigationController*)navigationController andView:(UIView*)view;

- (void)hide;
@end
