

#import <UIKit/UIKit.h>
#import "GameSetup.h"


@interface GameSetup ()

// Private interface goes here.

@end


@implementation GameSetup


-(int)numPlayers
{
    int total = 0;
//    int numRole = 0;
    
    NSEntityDescription *gameSetupEntity = [NSEntityDescription entityForName:@"GameSetup" inManagedObjectContext:self.managedObjectContext];
    
    NSDictionary *attributes = [gameSetupEntity attributesByName];
    for (NSString *attribute in attributes) {
        
        if ([[attribute substringToIndex:3] isEqualToString:@"num"]) {
            id value = [self valueForKey:attribute];
            total += [value intValue];
            NSLog(@"attribute %@ = %@", attribute, value);
        }
        
    }
    
    
    
//    for (NSString *key in [self.roleNumbers allKeys]) {
//        numRole = [[self.roleNumbers objectForKey:key] intValue];
//        total = total + numRole;
//    }
    
    return total;
}

@end
