//
//  WerewolfTests.m
//  WerewolfTests
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Game.h"
#import "GameSetup.h"
#import "GameData.h"
#import "Player.h"

@interface WerewolfTests : XCTestCase
{
    GameSetup *defaultSetup;
    Game *game;
}
@end

@implementation WerewolfTests

- (void)setUp
{
    [super setUp];

    defaultSetup = [[[GameData sharedData] gameSetups] firstObject];
    game = [[Game alloc] initWithGameSetup:defaultSetup];
    [game prepareGame];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTAssertEqual(_firstName, _lastName, @"First name and Last name should be equal");
}

- (void)testKillingAPlayerKillsThemForGood
{
    Player *firstPlayer = [game players][0];
    
    XCTAssertFalse(firstPlayer.isDead, @"Player should not be dead yet");
    [game killPlayerAtIndex:0];
    XCTAssertTrue(firstPlayer.isDead, @"Player should be dead after calling killplayer");
}

@end
