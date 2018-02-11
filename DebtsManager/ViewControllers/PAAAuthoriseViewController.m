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
#import "Masonry.h"

NSString * const PAAAccessTokenReceivedNotification = @"PAAAccessTokenReceivedNotification";
NSString * const PAALoginUsingVkButtonText = @"Войти с помощью вк";
static CGFloat const PAAButtonHeight = 40.0;
static CGFloat const PAAButtonWidth = 200.0;

@interface PAAAuthoriseViewController()

@property (nonatomic, strong)SFSafariViewController *safariViewController;
@property (nonatomic, strong)UIButton *loginButton;

@end

@implementation PAAAuthoriseViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenReceivedWithNotification:) name:PAAAccessTokenReceivedNotification object:nil];
    [self addLoginButton];
    [self updateViewConstraints];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints
{
    [self setButtonConstraints];
    [super updateViewConstraints];
}


#pragma mark - UI

- (void)addLoginButton
{
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.loginButton setFrame:CGRectInset(self.view.frame, 100, 100)];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:PAALoginUsingVkButtonText forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(getAccessTokenUsingSafari) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.loginButton];
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


#pragma mark - Constraints

- (void)setButtonConstraints
{
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(PAAButtonHeight);
        make.width.mas_equalTo(PAAButtonWidth);
        make.center.equalTo(self.view);
    }];
}


@end
