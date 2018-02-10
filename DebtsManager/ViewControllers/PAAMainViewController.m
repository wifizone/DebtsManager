//
//  PAAMainViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAMainViewController.h"
#import "DebtPAA+CoreDataClass.h"
#import "AppDelegate.h"
#import "PAADebtTableViewCell.h"
#import "PAADebtViewController.h"
#import "PAACoreDataManager.h"
#import "PAANetworkService.h"

static CGFloat const PAARowHeight = 120.0;
static NSString * const PAADebtTableViewCellIdentifier = @"cellId";

@interface PAAMainViewController () <UITableViewDelegate, UITableViewDataSource, PAANetworkServiceOutputProtocol>

@property (nonatomic, strong) UITableView *tableViewWithDebts;
@property (nonatomic, copy) NSArray<DebtPAA *> *arrayWithDebts;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) PAANetworkService *networkService;

@end

@implementation PAAMainViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadModel];
    [self prepareUI];
    self.networkService = [PAANetworkService new];
    self.networkService.output = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self updateTableOfDebts];
}

#pragma mark - UI

- (void)updateTableOfDebts
{
    [self loadModel];
    [self.tableViewWithDebts reloadData];
}

- (void)prepareUI
{
    [self addTableViewWithDebts];
    [self createButtonAdd];
}

- (void)addTableViewWithDebts
{
    //изменить 20
    self.tableViewWithDebts = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame) + 20,self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableViewWithDebts.rowHeight = PAARowHeight;
    [self.view addSubview:self.tableViewWithDebts];
    self.tableViewWithDebts.dataSource = self;
    self.tableViewWithDebts.delegate = self;
    [self.tableViewWithDebts registerClass:[PAADebtTableViewCell class] forCellReuseIdentifier:PAADebtTableViewCellIdentifier];
    self.tableViewWithDebts.allowsMultipleSelection = NO;
}

- (void)createButtonAdd
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Добавить" style:UIBarButtonItemStylePlain target:self action:@selector(openDebtViewControllerToAddNewDebt)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - Navigation

- (void)openDebtViewControllerToAddNewDebt
{
    PAADebtViewController *debtViewController = [PAADebtViewController new];
    debtViewController.addFeatureIsNeeded = YES;
    [self.navigationController pushViewController:debtViewController animated:YES];
}

- (void)openDebtViewControllerToEditNewDebt:(NSIndexPath *)indexPath
{
    PAADebtViewController *debtViewController = [PAADebtViewController new];
    debtViewController.addFeatureIsNeeded = NO;
    debtViewController.currentDebt = self.arrayWithDebts[indexPath.row];
    [self.navigationController pushViewController:debtViewController animated:YES];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PAADebtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAADebtTableViewCellIdentifier];
    DebtPAA *debt = self.arrayWithDebts[indexPath.row];
    
    cell.personNameLabel.text = debt.personName;
    cell.sumToRepayLabel.text = [NSString stringWithFormat:@"%f", debt.debtSum];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.mm.yyyy"];
    cell.dueDateLabel.text = [formatter stringFromDate:debt.debtDueDate];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.networkService loadImageOfPerson:debt.personPhotoUrl forIndexPath:indexPath];
    });
    cell.personPhotoImage.image = [UIImage imageNamed:@"ok.png"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayWithDebts.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[PAACoreDataManager sharedCoreDataManager] deleteObject:self.arrayWithDebts[indexPath.row]];
        [self updateTableOfDebts];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self openDebtViewControllerToEditNewDebt:indexPath];
}


#pragma mark - PAANetworkServiceOutputProtocol

- (void)loadingIsDoneWithImageReceived:(NSData *)personPhoto forIndexPath:(NSIndexPath *)indexPath
{
    PAADebtTableViewCell *cell = [self.tableViewWithDebts cellForRowAtIndexPath:indexPath];
    UIImage *personImage = [UIImage imageWithData:personPhoto];
    cell.personPhotoImage.image = personImage;
}

#pragma mark - CoreDataManagement

- (void)loadModel
{
    self.arrayWithDebts = nil;
    self.arrayWithDebts = [[PAACoreDataManager sharedCoreDataManager] getCurrentModel];
}

@end
