# PirateBayCLI

A CLI tool to search and retrieve torrents from The Pirate Bay using a fuzzy finder interface — straight from your terminal.

## Features

- 🔍 Search torrents by title directly from the terminal
- 🎯 Interactive fuzzy finder (fzf) to pick the result
- 🧲 Returns the magnet link ready to use
- 👤 Shows uploader alongside the torrent name
- ⚡ Pure bash — no heavy dependencies

## Dependencies

| Tool | Purpose |
|------|---------|
| `curl` | Fetch HTML from TPB |
| `xmllint` | XPath parsing of HTML |
| `fzf` | Fuzzy finder interface |
| `grep` | Regex extraction |

### Installing dependencies

**Debian/Ubuntu:**
```bash
sudo apt install curl libxml2-utils fzf
```

**Arch Linux:**
```bash
sudo pacman -S curl libxml2 fzf
```

## Usage

```bash
chmod +x pbcli.sh
./pbcli.sh
```

1. Select **"Search Game:"** from the menu
2. Type the game title
3. Pick the result from the fuzzy finder
4. The magnet link is returned

## How it works

```
User input (title)
      ↓
curl → TPB search page
      ↓
xmllint XPath → extract names, IDs, uploaders
      ↓
fzf → user picks result
      ↓
magnet link output
```

## Future plans

- [ ] Serve results as a JSON API compatible with [Hydra Launcher](https://github.com/hydralauncher/hydra) download sources
- [ ] Contribute dynamic download source support upstream to Hydra
- [ ] Add support for other trackers

## Disclaimer

This tool is intended for educational purposes only. Make sure to comply with the laws of your country regarding copyright and piracy.
