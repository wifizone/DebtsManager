//
//  PAAFriendListTableViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


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
    [self setupTableView];
    [self addRefreshControl];
    [self loadFriendList];
}


#pragma mark - UI

- (void)setupTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PAADebtTableViewCellIdentifier];
}

- (void)addRefreshControl
{
    self.tableView.refreshControl = [UIRefreshControl new];
    [self.tableView.refreshControl addTarget:self action:@selector(downloadFriendList:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.tableView.refreshControl];
}

- (void)popFriendListViewController
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)downloadFriendList: (UIRefreshControl *)refreshControl
{
    [[PAACoreDataManager sharedCoreDataManager] clearContextFromInsertedFriendEntities];
    [self downloadFriendList];
}

- (void)loadingIsDoneWithJsonRecieved:(NSArray<NSDictionary *> *)friendItemsReceived;
{
    PAACoreDataManager *coredataManager = [PAACoreDataManager sharedCoreDataManager];
    [coredataManager importFriendListFromArrayOfDictionaries:friendItemsReceived];
    self.friendList = [coredataManager getCurrentFriendEntitiesFromInsertedObjectsInCoreDataContext];
    [self.tableView reloadData];
    [self.tableView.refreshControl endRefreshing];
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
