# Crossroads

The classic Roblox game, converted to a Rojo project automatically!

The only change I made to Crossroads for syncback to run was grouping all of the `SpawnLocation` Instances into a model named `SpawnLocations`.

This is a project that's mostly meant to test the syncback functionality of Rojo, but it's also a neat look at how [Crossroads](https://www.roblox.com/games/1818/Classic-Crossroads) is laid out.

## Building

If you want to build this into Crossroads, use a version of Rojo that supports reference properties. As of the time of writing, this is Uplift Games' fork, which you can download binaries for [here](https://github.com/UpliftGames/rojo/releases).

Then, simply build it as you normally would:

```bash
rojo build -o crossroads.rbxl
```

## Syncback

To run syncback over top of this, you need a version that has syncback (currently exclusive to Uplift Games' fork, linked above). Then, you simply run the following:

```bash
rojo syncback --input crossroads.rbxl
```

Optionally, you may also run the [`reset`](.lune/reset.luau) script to 'reset' the project, allowing you to get a fresh result. This may be necessary if e.g. something becomes a directory and you don't want to fix it manually.