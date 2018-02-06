//
//  PAAMainViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAMainViewController.h"
#import "Debt+CoreDataClass.h"
#import "PAACoreDataManager.h"
#import "AppDelegate.h"
#import "PAADebtTableViewCell.h"
#import "PAADebtViewController.h"

static CGFloat const PAARowHeight = 120.0;
static NSString * const PAADebtTableViewCellIdentifier = @"cellId";

@interface PAAMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableViewWithDebts;
@property (nonatomic, copy) NSArray *arrayWithDebts;
@property (nonatomic, strong)NSManagedObjectContext *coreDataContext;

@end

@implementation PAAMainViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadModel];
    [self prepareUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - UI

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
}

- (void)createButtonAdd {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Добавить" style:UIBarButtonItemStylePlain target:self action:@selector(openDebtViewControllerToAddNewDebt)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)openDebtViewControllerToAddNewDebt
{
    PAADebtViewController *debtViewController = [PAADebtViewController new];
    [self.navigationController pushViewController:debtViewController animated:YES];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PAADebtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAADebtTableViewCellIdentifier];
    Debt *debt = self.arrayWithDebts[indexPath.row];
    
    cell.personNameLabel.text = debt.personName;
    cell.sumToRepayLabel.text = [NSString stringWithFormat:@"%f", debt.debtSum];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd.mm.yyyy"];
    cell.dueDateLabel.text = [formatter stringFromDate:debt.debtDueDate];
    cell.personPhotoImage.image = [UIImage imageNamed:@"ok.png"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayWithDebts.count;
}


#pragma mark - CoreDataManagement

- (void)addObjectToCoreDataTest
{
    NSManagedObjectContext *context = [PAACoreDataManager sharedCoreDataManager].coreDataContext;
    Debt *debt = [NSEntityDescription insertNewObjectForEntityForName:@"Debt" inManagedObjectContext:context];
    debt.personName = @"Aleksandr";
    debt.personSurname = @"Konevskii";
    debt.personPhotoUrl = @"https://pp.userapi.com/c621323/v621323368/221ed/QK3Xj2XE7kM.jpg";
    debt.debtSum = 5000;
    NSDateComponents *dateComponents = [NSDateComponents new];
    [dateComponents setYear:2014];
    [dateComponents setMonth:01];
    [dateComponents setDay:28];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    debt.debtDueDate = [calendar dateFromComponents:dateComponents];
    debt.debtAppearedDate = [calendar dateFromComponents:dateComponents];
    
    NSError *error;
    
    if (![debt.managedObjectContext save:&error])
    {
        NSLog(@"Не удалось сохрнаить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
}

- (void)loadModel
{
    self.arrayWithDebts = nil;
    self.arrayWithDebts = [[PAACoreDataManager sharedCoreDataManager] getCurrentModel];
}

@end
