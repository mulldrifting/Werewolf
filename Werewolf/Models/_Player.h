// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Player.h instead.

#import <CoreData/CoreData.h>


extern const struct PlayerAttributes {
	__unsafe_unretained NSString *name;
} PlayerAttributes;

extern const struct PlayerRelationships {
} PlayerRelationships;

extern const struct PlayerFetchedProperties {
} PlayerFetchedProperties;




@interface PlayerID : NSManagedObjectID {}
@end

@interface _Player : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PlayerID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _Player (CoreDataGeneratedAccessors)

@end

@interface _Player (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
