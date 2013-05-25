//
//  ShokaFavorites.m
//  Shoka
//
//  Created by Xhacker on 2013-05-03.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaFavorites.h"

static NSString * const kFavoritesKey = @"Favorites";
static NSString * const kFavoriteStorageFormat = @"%@|%@";

@implementation ShokaFavorites

+ (void)addBookWithDocNumber:(NSString *)number andBase:(NSString *)base
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[defaults arrayForKey:kFavoritesKey] mutableCopy];
    if (!favorites) {
        favorites = [[NSMutableArray alloc] init];
    }
    [favorites addObject:[NSString stringWithFormat:kFavoriteStorageFormat, number, base]];
    [defaults setObject:favorites forKey:kFavoritesKey];
}

+ (void)removeBookWithDocNumber:(NSString *)number andBase:(NSString *)base
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[defaults arrayForKey:kFavoritesKey] mutableCopy];
    [favorites removeObject:[NSString stringWithFormat:kFavoriteStorageFormat, number, base]];
    [defaults setObject:favorites forKey:kFavoritesKey];    
}

+ (BOOL)hasBookWithDocNumber:(NSString *)number andBase:(NSString *)base
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *favorites = [defaults arrayForKey:kFavoritesKey];
    if (!favorites || [favorites indexOfObject:[NSString stringWithFormat:kFavoriteStorageFormat, number, base]] == NSNotFound) {
        return NO;
    }
    else {
        return YES;
    }
}

+ (NSArray *)list
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:kFavoritesKey];
}

@end
