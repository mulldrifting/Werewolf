

#import <UIKit/UIKit.h>
#import "GameSetup.h"


@interface GameSetup ()

// Private interface goes here.

@end


@implementation GameSetup


-(int)numPlayers
{
    int total = 0;
    int numRole = 0;
    
    NSDictionary *attributes = [self attributesByName];
    for (NSString *attribute in attributes) {
        
        
        
        if () {
            <#statements#>
        }
        
        id value = [myManagedObject valueForKey: attribute];
        NSLog(@"attribute %@ = %@", attribute, value);
    }
    
    for (<#type *object#> in <#collection#>) {
        <#statements#>
    }
    
//    for (NSString *key in [self.roleNumbers allKeys]) {
//        numRole = [[self.roleNumbers objectForKey:key] intValue];
//        total = total + numRole;
//    }
    
    return total;
}

@end
