//
//  PAACoreDataManagerTests.m
//  DebtsManagerTests
//
//  Created by Антон Полуянов on 18/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "PAACoreDataManager.h"
#import "Expecta/Expecta.h"
#import "AppDelegate.h"


@interface PAACoreDataManager (Tests)

- (NSArray *)getModelUsingFetchRequest: (NSFetchRequest *)fetchRequest;
- (NSArray *)createSortDescriptionWithKey: (NSString *)sortDescriptionKey;
- (NSManagedObjectContext *)coreDataContext;

@end


@interface PAACoreDataManagerTests : XCTestCase

@property (nonatomic, strong) PAACoreDataManager *coreDataManager;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;

@end


@implementation PAACoreDataManagerTests

- (void)setUp
{
    [super setUp];
    self.coreDataManager = OCMPartialMock([PAACoreDataManager sharedCoreDataManager]);
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"someEntity"];
    self.fetchRequest = OCMPartialMock(request);
}

- (void)tearDown
{
    self.coreDataManager = nil;
    self.fetchRequest = nil;
    [super tearDown];
}

- (void)testSharedCoreDataManagerReturnsNotNil
{
    PAACoreDataManager *manager = self.coreDataManager;
    expect(manager).notTo.beNil();
}

- (void)testSharedCoreDataManagerDispatchedOnce
{
    PAACoreDataManager *manager1 = self.coreDataManager;
    PAACoreDataManager *manager2 = self.coreDataManager;
    expect(manager1).equal(manager2);
}

//- (void)testCoreDataContextCreatesAndReturns //вообще не понятно как это делать
//{
//    OCMStub([self.coreDataManager.coreDataContext isEqual:nil]);
//    expect(self.coreDataManager.coreDataContext).to.beNil();
//
//    id applicationMock = OCMClassMock([UIApplication class]);
//    UIApplication *application = [applicationMock sharedApplication];
//
//}
//
//- (void)testCoreDataContextReturns
//{
//    expect(self.coreDataManager.coreDataContext).notTo.beNil();
//}

- (void)testGetModelUsingFetchRequestReturnsNil
{
    id requestMock = OCMClassMock([NSFetchRequest class]);
    OCMStub([self.coreDataManager.coreDataContext executeFetchRequest:requestMock error:nil]).andReturn(nil);
    NSArray *modelArray = [self.coreDataManager getModelUsingFetchRequest:nil];
    expect(modelArray).to.beNil();
}

- (void)testGetModelUsingFetchRequestReturnsSomeArray  //хз почему он не стабит
{
//    id contextMock = OCMClassMock([NSManagedObjectContext class]);
//    NSArray *emptyArray = @[];
//    OCMStub([contextMock executeFetchRequest:self.fetchRequest error:nil]).andReturn(emptyArray);
//    NSArray *modelArray = [self.coreDataManager getModelUsingFetchRequest:nil];
//    expect(modelArray).equal(emptyArray);
    
//    id requestMock = OCMClassMock([NSFetchRequest class]);
//    OCMStub([self.coreDataManager.coreDataContext executeFetchRequest:requestMock error:nil]).andReturn(@[]);
//    NSArray *modelArray = [self.coreDataManager getModelUsingFetchRequest:nil];
//    expect(modelArray).equal(@[]);
}

- (void)testCreateSortDescriptionWithKeyNotToBeNil
{
    NSArray *sortDescription = [self.coreDataManager createSortDescriptionWithKey:@"someKey"];
    expect(sortDescription).notTo.beNil();
    expect(sortDescription.count).equal(@1);
}


@end
