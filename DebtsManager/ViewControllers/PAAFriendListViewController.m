//
//  PAAFriendListTableViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import "PAAFriendListViewController.h"
#import "PAANetworkService.h"
#import "PAADebtViewController.h"


static NSString * const PAADebtTableViewCellIdentifier = @"cellId";


@interface PAAFriendListViewController () <UITableViewDataSource, UITableViewDelegate, PAANetworkServiceOutputProtocol>

@property (nonatomic, copy) NSArray<PAAFriend *> *friendList;

@end


@implementation PAAFriendListViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PAADebtTableViewCellIdentifier];
    [self loadFriendList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DownloadingFriendList

- (void)loadFriendList
{
    PAANetworkService *networkService = [PAANetworkService new];
    networkService.output = self;
    [networkService loadFriendListOfPerson];
}

-(void)loadingIsDoneWithJsonRecieved:(NSArray<NSDictionary *> *)friendItemsReceived;
{
    self.friendList = [PAAFriend getFriendListFromDictionaryArray:friendItemsReceived];
    [self.tableView reloadData];
    NSLog(@"json получен");
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAADebtTableViewCellIdentifier
                                                            forIndexPath:indexPath];
    PAAFriend *friendModel = self.friendList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friendModel.surname, friendModel.name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PAAFriend *friendModel = self.friendList[indexPath.row];
    [self.delegate friendListViewController:self didChooseFriend:friendModel];
}

@end
