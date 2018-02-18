//
//  PAAApiManagerTests.m
//  DebtsManagerTests
//
//  Created by Антон Полуянов on 18/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "PAAApiManager.h"
#import "Expecta/Expecta.h"


static NSString * const PAACorrectUrl = @"vk6355774://authorize#access_token=163337bf50063ab82cf4d35302708d54b1fa1e2aef3fd09df7255b28cdf959023097794a6b486e3edb81a&expires_in=0&user_id=17776407";
static NSString * const PAAIncorrectUrlNoAccessTokenNameParameter = @"token=163337bf50063ab82cf4d35302708d54b1fa1e2aef3fd09df7255b28cdf959023097794a6b486e3edb81a&expires_in=0&user_id=17776407";
static NSString * const PAAcorrectUrlNoAmpersandAtTheEnd = @"vk6355774://authorize#access_token=163337bf50063ab82cf4d35302708d54b1fa1e2aef3fd09df7255b28cdf959023097794a6b486e3edb81a";
static NSString * const PAACorrectToken = @"163337bf50063ab82cf4d35302708d54b1fa1e2aef3fd09df7255b28cdf959023097794a6b486e3edb81a";


@interface PAAApiManagerTests : XCTestCase

@property (nonatomic, strong) NSURL *urlWithToken;
@property (nonatomic, strong) NSURL *incorrectUrlNoAccessTokenNameParameter;
@property (nonatomic, strong) NSURL *correctUrlNoAmpersandAtTheEnd;
@property (nonatomic, strong) NSDictionary *jsonWithError;
@property (nonatomic, strong) NSDictionary *correctJson;

@end

@implementation PAAApiManagerTests

- (void)setUp {
    [super setUp];
    self.urlWithToken = [[NSURL alloc] initWithString:PAACorrectUrl];
    self.incorrectUrlNoAccessTokenNameParameter = [[NSURL alloc] initWithString:PAAIncorrectUrlNoAccessTokenNameParameter];
    self.correctUrlNoAmpersandAtTheEnd = [[NSURL alloc] initWithString:PAAcorrectUrlNoAmpersandAtTheEnd];
    self.jsonWithError = @{
                           @"error": @"someError"
                           };
    self.correctJson = @{
                         @"response": @{
                                 @"count": @"1",
                                 @"items": @{
                                         @"id": @"272697957",
                                         @"first_name": @"Ackap",
                                         @"last_name": @"Xaliullin",
                                         @"photo_200": @"https://pp.userapi.com/c840423/v840423944/143c3/TCIUHnRITIs.jpg",
                                         @"online": @"0"
                                         }
                                 }
                         };
}

- (void)tearDown {
    self.urlWithToken = nil;
    self.incorrectUrlNoAccessTokenNameParameter = nil;
    self.correctUrlNoAmpersandAtTheEnd = nil;
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testParseTokenFromUrlNilUrl
{
    NSString *token = [PAAApiManager parseTokenFromUrl:nil];
    expect(token).to.beNil();
}

- (void)testParseTokenFromUrlCorrectToken
{
    NSString *token = [PAAApiManager parseTokenFromUrl:self.urlWithToken];
    expect(token).equal(PAACorrectToken);
}

- (void)testParseTokenFromUrlIncorrectUrlNoAccessTokenNameParameter
{
    NSString *token = [PAAApiManager parseTokenFromUrl:self.incorrectUrlNoAccessTokenNameParameter];
    expect(token).to.beNil();
}

- (void)testParseTokenFromUrlNoAmpersandAtTheEnd
{
    NSString *token = [PAAApiManager parseTokenFromUrl:self.correctUrlNoAmpersandAtTheEnd];
    expect(token).equal(PAACorrectToken);
}

- (void)testParseFriendListInputNil
{
    NSArray *friendsDictionaries = [PAAApiManager parseFriendList:nil];
    expect(friendsDictionaries).to.beNil();
}

- (void)testParseFriendListJsonWithError
{
    NSArray *friendsDictionaries = [PAAApiManager parseFriendList:self.jsonWithError];
    expect(friendsDictionaries).to.beNil();
}

- (void)testParseFriendListCorrectJson
{
    NSArray *friendsDictionaries = [PAAApiManager parseFriendList:self.correctJson];
    NSDictionary *responseContainer = self.correctJson[@"response"];
    NSArray<NSDictionary *> *friendListItems = responseContainer[@"items"];
    expect(friendsDictionaries).equal(friendListItems);
}

@end
