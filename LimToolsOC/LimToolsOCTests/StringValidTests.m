//
//  StringValidTests.m
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Valid.h"

@interface StringValidTests : XCTestCase

@end

@implementation StringValidTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testValid {
    NSString *nilStr = nil;
    XCTAssertFalse(nilStr.valid, @"Valid function not word when string is nil");
    XCTAssertTrue(@"".valid, @"Valid function need check");
    XCTAssertTrue(@"12t ".valid, @"Valid function need check");
    XCTAssertTrue(@" ".valid, @"Valid fucntion need check");
}

- (void)testEmailValid {
    NSString *nilStr = nil;
    XCTAssertFalse(nilStr.emailValid, @"Email Valid not work");
    XCTAssertTrue(@"li12r@ui12.com".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"li  12r@ui12.com".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"li12r@ui 12.com".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"li12r@ui12.co m".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"@ui12.com".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"li12r@.com".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"li12r@ui12.".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"@.com".emailValid, @"Email Vaild not work");
    XCTAssertFalse(@"@.".emailValid, @"Email Vaild not work");
    XCTAssertTrue(@"09000.kjkdfk.kdjfkd@kdjfdk.cc",@"");
    XCTAssertTrue(@"00000@000.io",@"");
}

@end
