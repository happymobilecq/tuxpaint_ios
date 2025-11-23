/*
  ios.m

  Copyright (c) 2021-2022
  https://tuxpaint.org/

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  (See COPYING.txt)

  Last updated: December 11, 2022
*/

#import <Foundation/Foundation.h>
#include <unistd.h>
#include <sys/stat.h>
#include <limits.h>
#include "ios.h"


// -------------------------------------------------------------------------
// Helper: copy NSString filesystem path into static C buffer
// -------------------------------------------------------------------------
static const char *storePath(NSString *nsstr, char *buffer)
{
    strncpy(buffer, [nsstr fileSystemRepresentation], PATH_MAX - 1);
    buffer[PATH_MAX - 1] = 0;
    return buffer;
}


// -------------------------------------------------------------------------
// Initialization (currently unused)
// -------------------------------------------------------------------------
void apple_init(void)
{
    // intentionally blank
}

const char *apple_locale(void)
{
    return "";   // iOS provides locale elsewhere; unused for now
}


// -------------------------------------------------------------------------
// Fonts path — iOS apps cannot access ~/Library/Fonts.
// Usually fonts must be bundled; so return an empty or app-bundled path.
// -------------------------------------------------------------------------
const char *apple_fontsPath(void)
{
    static char buffer[PATH_MAX] = {0};
    if (buffer[0])
        return buffer;

    // Path to <AppBundle>/Fonts
    NSString *path = [[[NSBundle mainBundle] resourcePath]
                      stringByAppendingPathComponent:@"data/fonts"];

    return storePath(path, buffer);
}


// -------------------------------------------------------------------------
// Preferences path — App Support directory inside sandbox
// ~/Library/Application Support/TuxPaint  →  <sandbox>/Library/Application Support/TuxPaint
// -------------------------------------------------------------------------
const char *apple_preferencesPath(void)
{
    static char buffer[PATH_MAX] = {0};
    if (buffer[0])
        return buffer;

    NSArray *paths =
        NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                            NSUserDomainMask,
                                            YES);

    NSString *dir = [[paths firstObject]
                      stringByAppendingPathComponent:@"TuxPaint"];

    [[NSFileManager defaultManager] createDirectoryAtPath:dir
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];

    return storePath(dir, buffer);
}


// -------------------------------------------------------------------------
// Global prefs path (same location on iOS)
// -------------------------------------------------------------------------
const char *apple_globalPreferencesPath(void)
{
    return apple_preferencesPath();
}


// -------------------------------------------------------------------------
// Pictures path — <sandbox>/Documents
// -------------------------------------------------------------------------
const char *apple_picturesPath(void)
{
    static char buffer[PATH_MAX] = {0};
    if (buffer[0])
        return buffer;

    NSArray *paths =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask,
                                            YES);

    NSString *dir = [paths firstObject];
    return storePath(dir, buffer);
}


// -------------------------------------------------------------------------
// Move file to trash — iOS has no trash, so delete
// -------------------------------------------------------------------------
int apple_trash(const char *path)
{
    return unlink(path);
}

