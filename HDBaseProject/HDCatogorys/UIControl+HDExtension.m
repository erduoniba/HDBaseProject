//
//  UIControl+HDExtension.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import "UIControl+HDExtension.h"

#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

static char const * const hd_kSoundsKey = "hd_kSoundsKey";

@implementation UIControl (HDExtension)

- (void)hd_setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;
{
    // Remove the old UI sound.
    NSString *oldSoundKey = [NSString stringWithFormat:@"%zd", controlEvent];
    AVAudioPlayer *oldSound = [self hd_sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];

    // Set appropriate category for UI sounds.
    // Do not mute other playing audio.
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];

    // Find the sound file.
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];

    // Create and prepare the sound.
    NSError *error = nil;
    AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];

    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }

    NSString *controlEventKey = [NSString stringWithFormat:@"%zd", controlEvent];
    NSMutableDictionary *sounds = [self hd_sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];

    // Play the sound for the control event.
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setHd_sounds:(NSMutableDictionary *)sounds
{
    objc_setAssociatedObject(self, hd_kSoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)hd_sounds
{
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, hd_kSoundsKey);

    // If sounds is not yet created, create it.
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        // Save it for later.
        [self setHd_sounds:sounds];
    }

    return sounds;
}

@end
