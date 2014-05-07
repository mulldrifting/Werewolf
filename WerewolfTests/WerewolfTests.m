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
#import "Role.h"
#import "Werewolf.h"
#import "Villager.h"
#import "Priest.h"
#import "Seer.h"
#import "Vigilante.h"
#import "Hunter.h"
#import "Minion.h"
#import "Assassin.h"
#import "NightActionController.h"

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

    for (GameSetup *setup in [[GameData sharedData] defaultGameSetups]) {
        if ([setup.name isEqualToString:@"5P Special"]) {
            defaultSetup = setup;
        }
    }
    
    game = [[Game alloc] initWithGameSetup:defaultSetup];

}

- (void)tearDown
{
    game = nil;
    defaultSetup = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNewRoleSubclassInitializer
{
    Role *newRole = [[Werewolf alloc] initWithGame:game];
    XCTAssertTrue([newRole.name isEqualToString:@"Werewolf"], @"New Werewolf should have name Werewolf");
}

- (void)testNewRoleSubclassInitializerShouldShareGameAsSuperclass
{
    Role *newRole = [[Werewolf alloc] initWithGame:game];
    XCTAssertNotNil(newRole.game, @"New role should be initialized with Game object");
}

- (void)testNewRoleSubclassInitializerShouldAccessGameProperties
{
    Role *newRole = [[Werewolf alloc] initWithGame:game];
    XCTAssertEqual(newRole.game.numPlayers, game.numPlayers, @"The new role's game should contain same number of players as game");
}

- (void)testWerewolfMethodOverwriteGetNightInfo
{
    Role *newRole = [[Werewolf alloc] initWithGame:game];
    NSLog(@"%@", newRole.getNightZeroInfo);
}


- (void)testPlayerOfRoleIsSameObjectAsPlayer
{
    for (Player *player in game.players) {
        XCTAssertEqualObjects(player, player.role.player, @"Player should be same player as Player's role.player");
    }
}

- (void)testSeerSettings
{
    XCTAssertFalse([[defaultSetup.settings objectForKey:@"SEER_PEEKS_NIGHT_ZERO"] boolValue], @"9P Classic settings SEER_PEEKS_NIGHT_ZERO should be false");
}

- (void)testNewGamePlayersExist
{
    XCTAssertNotNil(game.players, @"Game's players array should not be nil");
}

- (void)testNewGameFirstPlayerExists
{
    XCTAssertNotNil(game.players[0], @"Game's first player should exist");
}

- (void)testKillingAPlayerKillsThemForGood
{
    Player *firstPlayer = [game players][0];
    
    XCTAssertFalse(firstPlayer.isDead, @"Player should not be dead yet");
    [game killPlayerAtIndex:0];
    XCTAssertTrue(firstPlayer.isDead, @"Player should be dead after calling killplayer");
}

- (void)testCheckGameState
{
    XCTAssertFalse(game.isOver, @"New game should not be over");
    [game checkGameState];
    XCTAssertFalse(game.isOver, @"New game should not be over after checking game state");
}

- (void)testTapLabelForRole
{
    Role *newRole = [[Werewolf alloc] initWithGame:game];
    NSLog(@"Tap label should overwrite superclass: %@",[newRole tapLabel]);
}

- (void)testWolfRandomPickForTwoPlayers
{
    Player *firstPlayer = game.players[0];
    Player *secondPlayer = game.players[1];
    [game.wolfTargets addObject:firstPlayer];
    [game.wolfTargets addObject:secondPlayer];
    
    if (game.wolfTargets.count > 0) {
        Player* targetPlayer = game.wolfTargets[arc4random_uniform((u_int32_t)[game.wolfTargets count])];
        targetPlayer.isWolfTarget = YES;
    }
    
    XCTAssertTrue(firstPlayer.isWolfTarget || secondPlayer.isWolfTarget, @"One out of two players in wolfTargets should be a wolf target.");
    XCTAssertFalse(firstPlayer.isWolfTarget && secondPlayer.isWolfTarget, @"Both players should not be wolfTargets");
}

- (void)testWolfRandomPickForOnePlayer
{
    Player *firstPlayer = game.players[0];
    [game.wolfTargets addObject:firstPlayer];
    
    if (game.wolfTargets.count > 0) {
        Player* targetPlayer = game.wolfTargets[arc4random_uniform((u_int32_t)[game.wolfTargets count])];
        targetPlayer.isWolfTarget = YES;
    }
    
    XCTAssertTrue(firstPlayer.isWolfTarget, @"When there's only one player in wolfTargets, that player should always be the target");
}

@end
