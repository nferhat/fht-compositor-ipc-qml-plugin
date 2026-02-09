<h1 align=center><code>fht-compositor-qml-plugin</code></h1>
<p align=center>A QML plugin to integrate [fht-compositor](fhtc) with [Quickshell](qs)</p>

This plugin bridges `fht-compositor`'s [IPC](https://github.com/nferhat/fht-compositor/tree/main/fht-compositor-ipc) with
[Quickshell](qs), in order to write desktop interfaces that rely on compositor data, such as workspace switchers,
window lists, and all that fun stuff.

## Example

```qml
import QtQuick
import Fhtc
import Quickshell

Item {
    id: root

    required property ShellScreen screen
    readonly property var activeWindow: FhtcWorkspaces.focusedWindow
    readonly property string screenName: screen?.name ?? ""
    // Get workspaces for this screen only, sorted by ID
    readonly property var screenWorkspaces: {
        return Object.values(FhtcWorkspaces.workspaces).filter(ws => ws.output === screenName).sort((a, b) => a.id - b.id);
    }
    // Active workspace index within this screen (0-based)
    readonly property int activeWorkspaceIndex: {
        if (!FhtcWorkspaces.activeWorkspace)
            return -1;
        return FhtcWorkspaces.activeWorkspace.id % 9;
    }

    // ... now use the data you fetched ...
}
```

## Install

- On Nix: You can use the provided `flake.nix`, override `nixpkgs` and install `fht-compositor-qml-plugin`

## Credits

- @Ardox, for making the initial implementation

[qs]: https://quickshell.org
[fhtc]: https://nferhat.github.io/fht-compositor
