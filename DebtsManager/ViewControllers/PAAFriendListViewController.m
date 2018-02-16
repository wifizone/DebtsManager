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
#import "FriendPAA+CoreDataClass.h"
#import "PAACoreDataManager.h"


static NSString * const PAADebtTableViewCellIdentifier = @"cellId";


@interface PAAFriendListViewController () <UITableViewDataSource, UITableViewDelegate, PAANetworkServiceOutputProtocol>

@property (nonatomic, copy) NSArray<FriendPAA *> *friendList;

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
    PAACoreDataManager *coredataManager = [PAACoreDataManager sharedCoreDataManager];
    self.friendList = [coredataManager getCurrentFriendEntitiesFromInsertedObjectsInCoreDataContext];
    if (self.friendList.count != 0)
    {
        [self.tableView reloadData];
        return;
    }
    [self downloadFriendList];
}

- (void)downloadFriendList
{
    PAANetworkService *networkService = [PAANetworkService new];
    networkService.output = self;
    [networkService loadFriendListOfPerson];
}

- (void)loadingIsDoneWithJsonRecieved:(NSArray<NSDictionary *> *)friendItemsReceived;
{
    PAACoreDataManager *coredataManager = [PAACoreDataManager sharedCoreDataManager];
    [coredataManager importFriendListFromArrayOfDictionaries:friendItemsReceived];
    self.friendList = [coredataManager getCurrentFriendEntitiesFromInsertedObjectsInCoreDataContext];
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
    FriendPAA *friendModel = self.friendList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friendModel.surname, friendModel.name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendPAA *friendModel = self.friendList[indexPath.row];
    [self.delegate friendListViewController:self didChooseFriend:friendModel];
}

@end
