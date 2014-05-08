// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Player.m instead.

#import "_Player.h"

const struct PlayerAttributes PlayerAttributes = {
	.name = @"name",
};

const struct PlayerRelationships PlayerRelationships = {
};

const struct PlayerFetchedProperties PlayerFetchedProperties = {
};

@implementation PlayerID
@end

@implementation _Player

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Player";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Player" inManagedObjectContext:moc_];
}

- (PlayerID*)objectID {
	return (PlayerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;











@end
