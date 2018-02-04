//
//  PAAMainViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAMainViewController.h"
#import "Debt+CoreDataClass.h"
#import "AppDelegate.h"
#import "PAADebtTableViewCell.h"
#import "PAADebtViewController.h"

static CGFloat const PAARowHeight = 90.0;
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
    [self prepareUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UI

- (void)prepareUI
{
    self.arrayWithDebts = @[@{
                                @"Name":@"Антон",
                                @"SumToRepay":@500,
                                @"Date":@"19.03.1995"
                                }];
    [self addTableViewWithDebts];
    [self createButtonAdd];
}

- (void)addTableViewWithDebts
{
    //изменить 20
    self.tableViewWithDebts = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.frame) + 20,self.view.bounds.size.width, self.view.bounds.size.height)
                                                           style:UITableViewStylePlain];
    self.tableViewWithDebts.rowHeight = PAARowHeight;
    [self.view addSubview:self.tableViewWithDebts];
    self.tableViewWithDebts.dataSource = self;
    self.tableViewWithDebts.delegate = self;
    [self.tableViewWithDebts registerClass:[PAADebtTableViewCell class] forCellReuseIdentifier:PAADebtTableViewCellIdentifier];
}

- (void)createButtonAdd {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Добавить" style:UIBarButtonItemStylePlain target:self action:@selector(openDebtViewController)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)openDebtViewController
{
    PAADebtViewController *debtViewController = [PAADebtViewController new];
    [self.navigationController pushViewController:debtViewController animated:YES];
}

//- (void)createButtonDelete {
//    self.view.backgroundColor = [UIColor greenColor];
//
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Удалить" style:UIBarButtonItemStylePlain target:self action:@selector(deleteEntry)];
//    self.navigationItem.leftBarButtonItem = leftItem;
//}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PAADebtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PAADebtTableViewCellIdentifier];
    NSDictionary *object = self.arrayWithDebts[indexPath.row];
    
    cell.personNameLabel.text = object[@"Name"];
    cell.sumToRepayLabel.text = [object[@"SumToRepay"] stringValue]; 
    cell.dueDateLabel.text = object[@"Date"];
    cell.personPhotoImage.image = [UIImage imageNamed:@"ok.png"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayWithDebts.count;
}

#pragma mark - CoreDataManagement

- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *) (application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

@end
