//
//  AQSLINEActivityTests.m
//  AQSLINEActivityTests
//
//  Created by kaiinui on 2014/11/08.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>

#import "AQSLINEActivity.h"

@interface AQSLINEActivity (Test)

- (BOOL)isLINEInstalled;
- (NSURL *)lineShareURLWithImage:(UIImage *)image;
- (NSURL *)lineShareURLWithText:(NSString *)text;
- (NSURL *)lineShareURLWithActivityItems:(NSArray *)activityItems;

@end

@interface AQSLINEActivityTests : XCTestCase

@property AQSLINEActivity *activity;

@end

@implementation AQSLINEActivityTests

- (void)setUp {
    [super setUp];
    
    _activity = [[AQSLINEActivity alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItsActivityCategoryIsShare {
    XCTAssertTrue(AQSLINEActivity.activityCategory == UIActivityCategoryShare);
}

- (void)testItReturnsItsImage {
    XCTAssertNotNil(_activity.activityImage);
}

- (void)testItReturnsItsType {
    XCTAssertTrue([_activity.activityType isEqualToString:@"org.openaquamarine.line"]);
}

- (void)testItReturnsItsTitle {
    XCTAssertTrue([_activity.activityTitle isEqualToString:@"LINE"]);
}

- (void)testItCannotPerformActivityIfLINENotInstalled {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isLINEInstalled]).andReturn(NO);
    
    NSArray *activityItems = @[@"hoge"];
    XCTAssertFalse([activity canPerformWithActivityItems:activityItems]);
}

- (void)testItCannotPerformActivityWithNothing {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isLINEInstalled]).andReturn(YES);
    
    NSArray *activityItems = @[];
    XCTAssertFalse([activity canPerformWithActivityItems:activityItems]);
}

- (void)testItCanPerformActivityWithString {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isLINEInstalled]).andReturn(YES);
    
    NSArray *activityItems = @[@"hoge"];
    XCTAssertTrue([activity canPerformWithActivityItems:activityItems]);
}

- (void)testItCanPerformActivityWithURL {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isLINEInstalled]).andReturn(YES);
    
    XCTAssertTrue([activity canPerformWithActivityItems:@[[NSURL URLWithString:@"http://google.com/"]]]);
}

- (void)testItCanPerformActivityWithImage {
    id activity = [OCMockObject partialMockForObject:_activity];
    OCMStub([activity isLINEInstalled]).andReturn(YES);
    
    XCTAssertTrue([activity canPerformWithActivityItems:@[[UIImage imageNamed:@"AQSLINEActivity"]]]);
}

- (void)testItReturnsShareURLWithText {
    XCTAssertTrue([[_activity lineShareURLWithText:@"whoa"].absoluteString isEqualToString:@"line://msg/text/whoa"]);
}

- (void)testItReturnsShareURLWithImage {
    NSURL *url = [_activity lineShareURLWithImage:[UIImage imageNamed:@"AQSLINEActivity"]];
    NSURL *noLastPathComponentURL = [url URLByDeletingLastPathComponent];
    XCTAssertTrue([noLastPathComponentURL.absoluteString isEqualToString:@"line://msg/image/"]);
}

- (void)testItCopiesImageToClipboardForPreparingShare {
    NSURL *URL = [_activity lineShareURLWithImage:[UIImage imageNamed:@"AQSLINEActivity"]];
    NSString *pasteboardName = URL.lastPathComponent;
    
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:pasteboardName create:NO];
    
    XCTAssertNotNil([pasteboard dataForPasteboardType:@"public.png"]);
}

- (void)testItReturnsImageShareURLWithTextAndImage {
    NSArray *items = @[@"whoa", [UIImage imageNamed:@"AQSLINEActivity"]];
    NSURL *URL = [_activity lineShareURLWithActivityItems:items];
    NSURL *noLastPathURL = [URL URLByDeletingLastPathComponent];
    
    XCTAssertTrue([noLastPathURL.absoluteString isEqualToString:@"line://msg/image/"]);
}

- (void)testItReturnsTextAndURLShareURLWithTextAndURL {
    NSArray *items = @[@"whoa", [NSURL URLWithString:@"http://google.com/"]];
    NSURL *URL = [_activity lineShareURLWithActivityItems:items];
    
    XCTAssertTrue([URL.absoluteString isEqualToString:@"line://msg/text/whoa%20http%3A%2F%2Fgoogle.com%2F"]);
}

- (void)testItReturnsTextShareURLWithText {
    NSURL *URL = [_activity lineShareURLWithActivityItems:@[@"whoa"]];
    
    XCTAssertTrue([URL.absoluteString isEqualToString:@"line://msg/text/whoa"]);
}

- (void)testItReturnsURLAsTextShareURLWithURL {
    NSURL *URL = [_activity lineShareURLWithActivityItems:@[[NSURL URLWithString:@"http://google.com/"]]];
    
    XCTAssertTrue([URL.absoluteString isEqualToString:@"line://msg/text/http%3A%2F%2Fgoogle.com%2F"]);
}

- (void)testItInvokesActivityDidFinishWithYES {
    id activity = [OCMockObject partialMockForObject:_activity];
    [[activity expect] activityDidFinish:YES];
    
    [activity performActivity];
    
    [activity verify];
}

@end
