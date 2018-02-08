//
//  PAAAuthoriseViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 01/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAAuthoriseViewController.h"
#import "SafariServices/SafariServices.h"
#import "PAAApiManager.h"
#import "PAAMainViewController.h"

NSString * const PAAAccessTokenReceivedNotification = @"PAAAccessTokenReceivedNotification";
static CGFloat const PAAButtonHeight = 40.0;
static CGFloat const PAAButtonWidth = 200.0;

@interface PAAAuthoriseViewController()

@property (nonatomic, strong)SFSafariViewController *safariViewController;

@end

@implementation PAAAuthoriseViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenReceivedWithNotification:) name:PAAAccessTokenReceivedNotification object:nil];
    [self addLoginButton];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)addLoginButton
{
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectInset(self.view.frame, 100, 100)];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"Зайти с помощью вк" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(getAccessTokenUsingSafari) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: loginButton];
}

- (void)presentMainViewController
{
    PAAMainViewController *mainViewController = [PAAMainViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma mark - ManagingAcessTokenWithSafariView

- (void)getAccessTokenUsingSafari
{
    NSString *loginPageUrlString = [PAAApiManager getAuthorizaitionUrl];
    NSURL *loginPageUrl = [NSURL URLWithString:loginPageUrlString];
    self.safariViewController = [[SFSafariViewController alloc] initWithURL:loginPageUrl];
    [self presentViewController:self.safariViewController animated:YES completion:nil];
}

- (void)tokenReceivedWithNotification:(NSNotification *)notification
{
    [PAAApiManager saveAccessTokenToUserDefaults:notification.object];
    NSLog(@"Пришел токен, сохранен в userDefaults");
    [self.safariViewController dismissViewControllerAnimated:YES completion:^{
        [self presentMainViewController];
    }];
}


@end
