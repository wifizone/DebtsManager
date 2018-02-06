//
//  PAAFriendListTableViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAFriendListViewController.h"
#import "PAAFriendListTableViewCell.h"
#import "PAANetworkService.h"

static NSString * const PAADebtTableViewCellIdentifier = @"cellId";

@interface PAAFriendListViewController () <UITableViewDataSource, UITableViewDelegate, PAANetworkServiceOutputProtocol>

@property (nonatomic, copy) NSArray<NSDictionary *> *friendList;

@end

@implementation PAAFriendListViewController

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

- (void)loadFriendList
{
    PAANetworkService *networkService = [PAANetworkService new];
    networkService.output = self;
    [networkService loadFriendListOfPerson];
}

-(void)loadingIsDoneWithJsonRecieved:(NSArray *)friendItemsReceived;
{
    self.friendList = [friendItemsReceived copy];  //проверить с копи
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAADebtTableViewCellIdentifier forIndexPath:indexPath];
    NSString *name = self.friendList[indexPath.row][@"first_name"];
    NSString *surname = self.friendList[indexPath.row][@"last_name"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", surname, name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
