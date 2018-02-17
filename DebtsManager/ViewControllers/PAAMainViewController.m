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
#import "Masonry.h"


static CGFloat const PAARowHeight = 120.0;
static CGFloat const PAANavBarAndStatusBarOffsetTableViewOffset = 66.0;
static CGFloat const PAATableViewOffset = 0;
static NSString * const PAADebtTableViewCellIdentifier = @"cellId";
static NSString * const PAAPlaceHolderImageName = @"ok.png";
static NSString * const PAANavigationBarTitle = @"Долги";
static NSString * const PAANamePrefixInLabel = @"Имя: %@ %@";
static NSString * const PAASumPrefixInLabel = @"Долг: %.0f рублей";
static NSString * const PAADatePrefixInLabel = @"Возвратить: %@";


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
    self.navigationController.navigationBar.topItem.title = PAANavigationBarTitle;
    [self addTableViewWithDebts];
    [self createButtonAdd];
    [self updateViewConstraints];
}

- (void)addTableViewWithDebts
{
    self.tableViewWithDebts = [UITableView new];
    self.tableViewWithDebts.rowHeight = PAARowHeight;
    [self.view addSubview:self.tableViewWithDebts];
    self.tableViewWithDebts.dataSource = self;
    self.tableViewWithDebts.delegate = self;
    [self.tableViewWithDebts registerClass:[PAADebtTableViewCell class]
                    forCellReuseIdentifier:PAADebtTableViewCellIdentifier];
    self.tableViewWithDebts.allowsMultipleSelection = NO;
}

- (void)createButtonAdd
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Добавить"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(openDebtViewControllerToAddNewDebt)];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - Navigation

- (void)openDebtViewControllerToAddNewDebt
{
    PAADebtViewController *debtViewController = [PAADebtViewController new];
    debtViewController.addFeatureIsNeeded = YES;
    [self.navigationController pushViewController:debtViewController animated:YES];
}

- (void)openDebtViewControllerToEditNewDebtForIndexPath:(NSIndexPath *)indexPath
{
    PAADebtViewController *debtViewController = [PAADebtViewController new];
    debtViewController.addFeatureIsNeeded = NO;
    debtViewController.currentDebt = self.arrayWithDebts[indexPath.row];
    [self.navigationController pushViewController:debtViewController animated:YES];
}


#pragma mark - Constraints

- (void)updateViewConstraints
{
    UIEdgeInsets padding = UIEdgeInsetsMake(PAANavBarAndStatusBarOffsetTableViewOffset,
                                            PAATableViewOffset, PAATableViewOffset, PAATableViewOffset);
    [self.tableViewWithDebts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    [super updateViewConstraints];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)populateTableWithTextForCell:(PAADebtTableViewCell *)cell debt:(DebtPAA *)debt
{
    cell.personNameLabel.text = [NSString stringWithFormat:PAANamePrefixInLabel, debt.friend.name, debt.friend.surname];
    cell.sumToRepayLabel.text = [NSString stringWithFormat:PAASumPrefixInLabel, debt.sum];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    cell.dueDateLabel.text = [NSString stringWithFormat:PAADatePrefixInLabel,
                              [formatter stringFromDate:debt.dueDate]];
}

- (void)populateTableWithImageForCell:(PAADebtTableViewCell *)cell debt:(DebtPAA *)debt indexPath:(NSIndexPath * _Nonnull)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.networkService loadImageOfPerson:debt.friend.photoUrl forIndexPath:indexPath];
    });
    cell.personPhotoImage.image = [UIImage imageNamed:PAAPlaceHolderImageName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PAADebtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAADebtTableViewCellIdentifier];
    DebtPAA *debt = self.arrayWithDebts[indexPath.row];
    [self populateTableWithTextForCell:cell debt:debt];
    [self populateTableWithImageForCell:cell debt:debt indexPath:indexPath];
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

- (void)tableView:(UITableView *)tableView  //выглядит зашкварно
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[PAACoreDataManager sharedCoreDataManager] deleteObject:self.arrayWithDebts[indexPath.row]];
        [self updateTableOfDebts];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self openDebtViewControllerToEditNewDebtForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    
    if(cell.layer.position.x != 0)
    {
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.3];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    
    [UIView commitAnimations];
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
    self.arrayWithDebts = [[PAACoreDataManager sharedCoreDataManager] getCurrentDebtModel];
}

@end
