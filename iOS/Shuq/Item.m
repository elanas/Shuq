//
//  Item.m
//  Shuq
//
//  Created by Elana Stroud on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ShuqModel.h"
#import "Item.h"

@implementation Item

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil


-(id)initWithName:(NSString*)name andPath:(NSString*) path andDesc:(NSString*) d andValue:(NSUInteger *)v{
    self = [super init];
    
    if (self) {
        title = name;
        pathname = path;
        desc = d;
        value = v;
        tags = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithName:(NSString*)name {
    self = [super init];
    
    if (self) {
        title = name;
        tags = [[NSMutableArray alloc] init];
    }
    return self;

}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    
    if (self) {
        ShuqModel *model = [ShuqModel getModel];
        tags = [[NSMutableArray alloc] init];
        
        title = dictionary[@"name"];
        desc = dictionary[@"description"];
        imageId = dictionary[@"imageId"];
        if(imageId != nil) {
            //load image
            [model loadImage:self];
        }
        
        NSMutableArray* tagJSON = dictionary[@"taglist"];
        for(NSUInteger n=0; n< [tagJSON count]; n++)
        {
            [self addTag:[tagJSON objectAtIndex:n][@"tagname"]];
        }
        
    }
    return self;
}


-(NSString*) getName {
    return title;
}

-(NSString*) getPath {
    return pathname;
}

-(NSString*) getDesc {
    return desc;
}

-(void) setDesc: (NSString*) d {
    desc = d;
}


-(NSUInteger*) getValue {
    return value;
}

-(NSMutableArray*) getTags {
    return tags;
}
-(void) addTag: (NSString *) t{
    Tag* tag = [[Tag alloc] initWithName:t];
    [tags addObject:tag];
}
-(void) setImageId: (NSString*) iid{
    imageId= iid;
    //NSLog(@"setting: %@", imageId);
}

-(NSString *) getImageID {
    //NSLog(@"getting: %@", imageId);
    return imageId;
}

-(UIImage *) getImage {
    return image;
}

-(void) setImage: (UIImage*) i {
    image = i;
}



@end
