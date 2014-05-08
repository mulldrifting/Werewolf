// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GameData.m instead.

#import "_GameData.h"

const struct GameDataAttributes GameDataAttributes = {
};

const struct GameDataRelationships GameDataRelationships = {
	.gameSetups = @"gameSetups",
};

const struct GameDataFetchedProperties GameDataFetchedProperties = {
};

@implementation GameDataID
@end

@implementation _GameData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"GameData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"GameData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"GameData" inManagedObjectContext:moc_];
}

- (GameDataID*)objectID {
	return (GameDataID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic gameSetups;

	
- (NSMutableSet*)gameSetupsSet {
	[self willAccessValueForKey:@"gameSetups"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"gameSetups"];
  
	[self didAccessValueForKey:@"gameSetups"];
	return result;
}
	






@end
