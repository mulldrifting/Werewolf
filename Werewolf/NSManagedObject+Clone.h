//
//  NSManagedObject+Clone.h
//  Tone Poet
//
//  Created by Mason Kramer on 5/31/13.
//  Copyright (c) 2013 Mason Kramer. The contents of this file are available
//  for use by anyone, for any purpose whatsoever.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (Clone) {
}

-(NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context withCopiedCache:(NSMutableDictionary *)alreadyCopied excludeEntities:(NSArray *)namesOfEntitiesToExclude;
-(NSManagedObject *)cloneInContext:(NSManagedObjectContext *)context excludeEntities:(NSArray *)namesOfEntitiesToExclude;
-(NSManagedObject *) clone;

@end