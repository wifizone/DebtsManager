//
//  PAANetworkServiceTests.m
//  DebtsManagerTests
//
//  Created by Антон Полуянов on 19/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "PAANetworkService.h"
#import "Expecta/Expecta.h"


static NSString * const PAAFriendIdsRequest = @"https://api.vk.com/method/friends.get?order=name&fields=photo_200&v=5.71&access_token=%@";


@interface PAANetworkService()

- (NSMutableURLRequest *)getConfiguredRequestForUrl:(NSString *)urlString;
@property (nonatomic, strong) NSURLSession *session;

@end


@interface PAANetworkServiceTests : XCTestCase

@property (nonatomic, strong)PAANetworkService *networkService;
@property (nonatomic, strong)NSMutableURLRequest *urlRequest;
@property (nonatomic, strong)NSURLSession *testSession;

@end

@implementation PAANetworkServiceTests

- (void)setUp {
    [super setUp];
    self.networkService = OCMPartialMock([PAANetworkService new]);
    
    NSString *getFriendsUrlString = [NSString stringWithFormat:PAAFriendIdsRequest, @"token12345"];
    NSMutableURLRequest *testRequest = [NSMutableURLRequest new];
    [testRequest setURL:[NSURL URLWithString:getFriendsUrlString]];
    [testRequest setHTTPMethod:@"GET"];
    [testRequest setValue:@"application/x-ww-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [testRequest setTimeoutInterval:15];
    self.urlRequest = OCMPartialMock(testRequest);
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    self.testSession = OCMPartialMock(session);
    
}

- (void)tearDown {
    self.networkService = nil;
    self.urlRequest = nil;
    self.testSession = nil;
    [super tearDown];
}

- (void)testGetConfiguredRequestForUrlReturnNilWhenNilUrlString
{
    NSMutableURLRequest *request = [self.networkService getConfiguredRequestForUrl:nil];
    expect(request).to.beNil();
}

- (void)testGetConfiguredRequestForUrlReturnsRequestWithCorrectUrl
{
    NSString *someRequest = @"http://vk.api/get";
    NSMutableURLRequest *request = [self.networkService getConfiguredRequestForUrl:someRequest];
    expect(request.URL.absoluteString).equal(someRequest);
}

- (void)testLoadFriendListOfPersonSessionIsNil
{
    self.networkService.session = nil;
    [self.networkService loadFriendListOfPerson];
    OCMVerify(return);
}

- (void)testLoadFriendListOfPersonSessionIsNotNil
{
    self.networkService.session = self.testSession;
    NSURL *someUrl = [NSURL URLWithString:@"someUrl"];
    NSURLSessionDataTask *datatask = [self.testSession dataTaskWithURL:someUrl];
    OCMStub([self.networkService getConfiguredRequestForUrl:[OCMArg any]]).andReturn(self.urlRequest);
    [self.networkService loadFriendListOfPerson];
    OCMVerify([datatask resume]);
}

- (void)testloadImageOfPersonSessionIsNil
{
    self.networkService.session = nil;
    [self.networkService loadImageOfPerson:@"someUrl"];
    OCMVerify(return);
}

- (void)testloadImageOfPersonImageUrlIsNil
{
    [self.networkService loadImageOfPerson:nil];
    OCMVerify(return);
}

- (void)testLoadImageOfPersonSessionIsNotNil
{
    self.networkService.session = self.testSession;
    NSURL *someUrl = [NSURL URLWithString:@"someUrl"];
    NSURLSessionDataTask *datatask = [self.testSession dataTaskWithURL:someUrl];
    OCMStub([self.networkService getConfiguredRequestForUrl:[OCMArg any]]).andReturn(self.urlRequest);
    [self.networkService loadImageOfPerson:@"someUrl"];
    OCMVerify([datatask resume]);
}

- (void)testloadImageOfPersonForIndexPathSessionIsNil
{
    self.networkService.session = nil;
    [self.networkService loadImageOfPerson:@"someUrl" forIndexPath:[NSIndexPath new]];
    OCMVerify(return);
}

- (void)testloadImageOfPersonForIndexPathImageUrlIsNil
{
    [self.networkService loadImageOfPerson:nil forIndexPath:[NSIndexPath new]];
    OCMVerify(return);
}

- (void)testloadImageOfPersonForIndexPathIndexPathIsNil
{
    [self.networkService loadImageOfPerson:@"somrUrl" forIndexPath:nil];
    OCMVerify(return);
}

- (void)testLoadImageOfPersonForIndexPathSessionIsNotNil
{
    self.networkService.session = self.testSession;
    NSURL *someUrl = [NSURL URLWithString:@"someUrl"];
    NSURLSessionDataTask *datatask = [self.testSession dataTaskWithURL:someUrl];
    OCMStub([self.networkService getConfiguredRequestForUrl:[OCMArg any]]).andReturn(self.urlRequest);
    [self.networkService loadImageOfPerson:@"someUrl" forIndexPath:[NSIndexPath new]];
    OCMVerify([datatask resume]);
}




@end
