//
//  NSManagedObject+Clone.m
//  Tone Poet
//
//  Created by Mason Kramer on 5/31/13.
//  Copyright (c) 2013 Mason Kramer. The contents of this file are available
//  for use by anyone, for any purpose whatsoever.
//


#import "NSManagedObject+Clone.h"

@implementation NSManagedObject (Clone)

-(NSManagedObject *) clone {
    return [self cloneInContext:[self managedObjectContext] excludeEntities:@[]];
}

- (NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context withCopiedCache:(NSMutableDictionary *)alreadyCopied excludeEntities:(NSArray *)namesOfEntitiesToExclude {
    NSString *entityName = [[self entity] name];
    
    if ([namesOfEntitiesToExclude containsObject:entityName]) {
        return nil;
    }
    
    NSManagedObject *cloned = [alreadyCopied objectForKey:[self objectID]];
    if (cloned != nil) {
        return cloned;
    }
    
    //create new object in data store
    cloned = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    [alreadyCopied setObject:cloned forKey:[self objectID]];
    
    //loop through all attributes and assign then to the clone
    NSDictionary *attributes = [[NSEntityDescription entityForName:entityName inManagedObjectContext:context] attributesByName];
    
    for (NSString *attr in attributes) {
        [cloned setValue:[self valueForKey:attr] forKey:attr];
    }
    
    //Loop through all relationships, and clone them.
    NSDictionary *relationships = [[NSEntityDescription entityForName:entityName inManagedObjectContext:context] relationshipsByName];
    for (NSString *relName in [relationships allKeys]){
        NSRelationshipDescription *rel = [relationships objectForKey:relName];
        
        NSString *keyName = rel.name;
        if ([rel isToMany]) {
            if ([rel isOrdered]) {
                NSMutableOrderedSet *sourceSet = [self mutableOrderedSetValueForKey:keyName];
                NSMutableOrderedSet *clonedSet = [cloned mutableOrderedSetValueForKey:keyName];
                
                NSEnumerator *e = [sourceSet objectEnumerator];
                
                NSManagedObject *relatedObject;
                while ( relatedObject = [e nextObject]){
                    //Clone it, and add clone to set
                    NSManagedObject *clonedRelatedObject = [relatedObject cloneInContext:context withCopiedCache:alreadyCopied excludeEntities:namesOfEntitiesToExclude];
                    
                    
                    [clonedSet addObject:clonedRelatedObject];
                    [clonedSet addObject:clonedRelatedObject];
                }
            }
            else {
                NSMutableSet *sourceSet = [self mutableSetValueForKey:keyName];
                NSMutableSet *clonedSet = [cloned mutableSetValueForKey:keyName];
                NSEnumerator *e = [sourceSet objectEnumerator];
                NSManagedObject *relatedObject;
                while ( relatedObject = [e nextObject]){
                    //Clone it, and add clone to set
                    NSManagedObject *clonedRelatedObject = [relatedObject cloneInContext:context withCopiedCache:alreadyCopied excludeEntities:namesOfEntitiesToExclude];
                    
                    [clonedSet addObject:clonedRelatedObject];
                }
            }
        }
        else {
            NSManagedObject *relatedObject = [self valueForKey:keyName];
            if (relatedObject != nil) {
                NSManagedObject *clonedRelatedObject = [relatedObject cloneInContext:context withCopiedCache:alreadyCopied excludeEntities:namesOfEntitiesToExclude];
                [cloned setValue:clonedRelatedObject forKey:keyName];
            }
        }
        
    }
    
    return cloned;
}

-(NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context excludeEntities:(NSArray *)namesOfEntitiesToExclude {
    return [self cloneInContext:context withCopiedCache:[NSMutableDictionary dictionary] excludeEntities:namesOfEntitiesToExclude];
}
@end