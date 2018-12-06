Mod Panels++ is a recreation of the Mod Panels mod by Nin.

It is compatible with mods that use the old API

Differences:
- Fewer bugs
- Mod panels always face you
- Uses steam browser (in-game one was a bit bugged)
- Is easier to use
- Has server-side configuration
- More customisation

# How to use

First of all, this mod must be on the server. Second of all, the mod panel must be
inside a mod and also be on the server.

If you want to disable or enable a mod panel without removing its mod, just use
the server-side configuration file named ModPanels.json. Set entries to `false` to disable
them, `true` to enable them. By default all mod panels are enabled.

# How to make a mod panel

Making a mod panel is quite simple, you must simply make two files:
- The image itself
- A descriptor for it

You must then put these two files into specific locations inside your NS2 mod.

## Making the image

The image itself I can not tell you how to make, you must use your imagination for that.
You must only make sure that you export it as a .tga file or .dds file.
Spark Engine (used by NS2) supports both. If you do use a DDS file, make sure to disable
mipmaps. Otherwise the mod panel will be unreadable by users that set their texture quality
to low values.

## Making the descriptor

The descriptor is simply a text file, with a few keys and corresponding values.

Each key-value pair is on a separate line.

An example descriptor is:
```
shader = "shaders/ModPanel.surface_shader"
panel  = "modpanels/wooza/badges.tga"
url    = "https://google.com"
name   = "my-awesome-tall-floating-shader-with-an-extremely-long-name"
size   = {0.5, 2}
offset = {0, 2, 0}
```

The first key `shader` you most likely do not want to change.
It is a required key and you almost always want it to be that value.

The second key `panel` points to your texture, and is also required.

The third key `url` is optional, and if set makes using (pressing E) the panel
open the URL in the steam web browser.

The fourth key `name` is optional and defaults to the path to the mod panel,
without the extension (E.g. `badges` instead of `badges.tga`).

The fifth key `size` is optional and defaults to {0.5, 0.5}.
The values are meters and represent the size of the mod panel in meters.
In the example the y-value is set to 2 to make it very tall.

The sixth key `offset` is a 3-dimensional vector and represents the offset
from the spawn point of the mod panel at which the mod panel's texture should float.
This is also optional and defaults to {0, 1, 0}, which makes it float 1 meter above the ground.

## Where to place these files

You must place the files in the modpanels directory, at the root of your mod.
If the folder does not exist, you must make it.

A good example is [here](https://github.com/woozasmoddingteam/Woozas-Potpourri/tree/master/src/modpanels),
as you can see there is a folder inside the folder named `wooza`. This is completely allowed, and the name
for the mod panels will then be inferred to be `wooza/<panel>`.

Once a client or server then loads Mod Panels++ while these files are available, they will be spawned and created
automatically in the world.

## Backwards-compatibility

This mod is fully backwards-compatible with the original Mod Panels mod by Nin.
The very same APIs are supported, so you can switch easily.
