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


@interface MLPBarAccordionMenu : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *menuItems;

- (id)initWithItems:(NSArray*)menuItems;

- (id)initWithDelegate:(id<UICollectionViewDelegate>)delegate;

- (void)toggleBetweenNavigationBar:(UINavigationController*)navigationController andView:(UIView*)view;

- (void)hide;
@end
