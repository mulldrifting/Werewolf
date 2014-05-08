// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameData.h instead.

#import <CoreData/CoreData.h>


extern const struct GameDataAttributes {
} GameDataAttributes;

extern const struct GameDataRelationships {
	__unsafe_unretained NSString *gameSetups;
} GameDataRelationships;

extern const struct GameDataFetchedProperties {
} GameDataFetchedProperties;

@class GameSetup;


@interface GameDataID : NSManagedObjectID {}
@end

@interface _GameData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (GameDataID*)objectID;





@property (nonatomic, strong) NSSet *gameSetups;

- (NSMutableSet*)gameSetupsSet;





@end

@interface _GameData (CoreDataGeneratedAccessors)

- (void)addGameSetups:(NSSet*)value_;
- (void)removeGameSetups:(NSSet*)value_;
- (void)addGameSetupsObject:(GameSetup*)value_;
- (void)removeGameSetupsObject:(GameSetup*)value_;

@end

@interface _GameData (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveGameSetups;
- (void)setPrimitiveGameSetups:(NSMutableSet*)value;


@end
