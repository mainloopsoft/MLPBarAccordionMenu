MLPBarAccordionMenu
================

![Screenshot](/screenshot.png "Screenshot")


About
---------
_MLPBarAccordionMenu_ allows you to toggle a menu from underneath a navigation bar as seen in the screenshot. It's based in 
UICollectionView.

Usage
---------
Add the _MLPBarAccordionMenu_ header and implementation file to your project. (.h & .m). QuartzCore is required too.

After doing that, create a menu instance with items, like this:

`MLPMenuItem *calendar = [[MLPMenuItem alloc] init];
calendar.icon = [UIImage imageNamed:@"calendar_32x32"];
calendar.title = @"Calendar";

   MLPMenuItem *camera = [[MLPMenuItem alloc] init];
    camera.icon = [UIImage imageNamed:@"camera_32x32"];
    camera.title = @"Camera";

    MLPMenuItem *cloud = [[MLPMenuItem alloc] init];
    cloud.icon = [UIImage imageNamed:@"cloud_32x20"];
    cloud.title = @"Cloud";
`
`   
    MLPMenuItem *refresh = [[MLPMenuItem alloc] init];
    refresh.icon = [UIImage imageNamed:@"loop_32x32"];
    refresh.title = @"Refresh";
`
`
    menu = [[MLPBarAccordionMenu alloc] initWithItems:@[calendar, camera, cloud, refresh]];
`

Then attach an action from a navigation item and call:

`[menu toggleInView:<view to push>];`

The view to push is the view between the navigation bar and where the menu will appear.

License
--------
_UIColor+MLPFlatColors_ uses the MIT License:

>Copyright (c) 2013, Mainloop LLC

>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
