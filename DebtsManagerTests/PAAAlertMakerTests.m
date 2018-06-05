//
//  PAAAlertMakerTests.m
//  DebtsManagerTests
//
//  Created by Антон Полуянов on 20/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "Expecta/Expecta.h"
#import "PAAAlertMaker.h"

@interface PAAAlertMakerTests : XCTestCase

@end

@implementation PAAAlertMakerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetAlertControllerWithTextMessageNil
{
    UIAlertController *controller = [PAAAlertMaker getAlertControllerWithText:nil];
    expect(controller).to.beNil();
}

- (void)testGetAlertControllerWithTextMessageNotNil
{
    NSString *message = @"someMessage";
    UIAlertController *controller = [PAAAlertMaker getAlertControllerWithText:message];
    expect(controller.message).equal(message);
}

@end
