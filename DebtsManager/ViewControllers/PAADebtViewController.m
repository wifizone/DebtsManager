//
//  PAADebtViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAADebtViewController.h"
#import "PAAFriendListViewController.h"

@interface PAADebtViewController ()

@end

@implementation PAADebtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareUI
{
    UIButton *chooseFromFriendListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseFromFriendListButton setFrame:CGRectMake(50, 50, 100, 50)];
    [chooseFromFriendListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chooseFromFriendListButton setTitle:@"Выбрать из списка друзей" forState:UIControlStateNormal];
    [chooseFromFriendListButton addTarget:self action:@selector(openFriendListViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseFromFriendListButton];
}

- (void)openFriendListViewController
{
    PAAFriendListViewController *friendListViewController = [PAAFriendListViewController new];
    [self.navigationController pushViewController:friendListViewController animated:YES];
}


@end
