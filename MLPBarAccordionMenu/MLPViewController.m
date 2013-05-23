//
//  MLPViewController.m
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPViewController.h"
#import "MLPBarAccordionMenu.h"

@interface MLPViewController ()
{
    MLPBarAccordionMenu *menu;
}
@end

@implementation MLPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MLPBarAccordionMenuItem *calendar = [[MLPBarAccordionMenuItem alloc] init];
    calendar.icon = [UIImage imageNamed:@"calendar_32x32"];
    calendar.title = @"Calendar";
    
    
    MLPBarAccordionMenuItem *camera = [[MLPBarAccordionMenuItem alloc] init];
    camera.icon = [UIImage imageNamed:@"camera_32x32"];
    camera.title = @"Camera";
    
    
    MLPBarAccordionMenuItem *cloud = [[MLPBarAccordionMenuItem alloc] init];
    cloud.icon = [UIImage imageNamed:@"cloud_32x20"];
    cloud.title = @"Cloud";
    
    MLPBarAccordionMenuItem *refresh = [[MLPBarAccordionMenuItem alloc] init];
    refresh.icon = [UIImage imageNamed:@"loop_32x32"];
    refresh.title = @"Refresh";
    
    menu = [[MLPBarAccordionMenu alloc] initWithItems:@[calendar, camera, cloud, refresh]];

    MLPBarAccordionMenuBlock block = ^(NSIndexPath *index) {
        //Do something here
        
        [menu hide];
    };
    
    menu.selectedBlock = block;
    menu.barButton = [menu barButtonItemWithImage:[UIImage  imageNamed:@"nav-arrow-down-icon"] target:self action:@selector(didSelectToggleButton:)];
    [self.navigationItem setRightBarButtonItem:menu.barButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectToggleButton:(id)sender {

    [menu toggleBetweenNavigationBar:self.navigationController andView:self.topView];
}

@end
