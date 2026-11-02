# Installation

This walkthrough covers a fresh install of one of the hosts in this flake, and the changes needed to adapt the configuration to your own machine.

Most of the system is declarative, but a few things cannot live in a public repository and are placed by hand. They are called **bootstrap secrets** below and are the only imperative part of the setup:

| Secret | Location on the machine | Used for |
| --- | --- | --- |
| sops age key | `/var/lib/sops/age/keys.txt` | Decrypting `secrets/secrets.yaml` |
| Root fallback hash | `/var/lib/secrets/root` (optional) | Emergency root login |
| SSH key | `~/.ssh/id_ed25519` | GitHub access and commit signing |

## 1. Prepare the installer

1. Boot the NixOS minimal or graphical ISO in UEFI mode. The config uses `systemd-boot`.
2. Get a network connection (`nmtui` or `iwctl`).
3. Enable flakes for the installer shell:

   ```sh
   export NIX_CONFIG="experimental-features = nix-command flakes"
   ```

4. Partition and format the disk, then mount it under `/mnt` (root) and `/mnt/boot` (the EFI partition, FAT32). Enable swap if you use it.

## 2. Get the configuration

The `rebuild-system` fish aliases assume the repository lives at `~/repos/nixos`, so clone it there once you are installed. For the install itself any path works:

```sh
nix shell nixpkgs#git
git clone https://github.com/mateushmd/nixos /mnt/etc/nixos-flake   # or your fork
cd /mnt/etc/nixos-flake
```

> Flakes only see files tracked by git. Whenever you add a new file or directory (a host, a module), run `git add` on it before building, or it is silently ignored.

## 3. Choose or create a host

Hosts are declared in `hosts/default.nix`:

```nix
phalanx = mkHost "phalanx" "x86_64-linux";
gaius = mkHost "gaius" "x86_64-linux";
```

### Installing an existing host

Skip to step 4.

### Creating a new host

1. Create `hosts/<name>/default.nix` and `hosts/<name>/hardware.nix`:

   ```sh
   mkdir hosts/<name>
   nixos-generate-config --root /mnt --show-hardware-config > hosts/<name>/hardware.nix
   ```

2. In `hosts/<name>/default.nix`, import the hardware file, set `system.stateVersion` to the release you are installing, and choose your options under `custom` (see `hosts/options.nix` for everything available). Use an existing host as a template.
3. Some options have no default and must be set when the feature is enabled:

   | Enabled option | Required |
   | --- | --- |
   | `custom.desktop.hyprland.enable` | `custom.desktop.hyprland.config` (the Hyprland Lua config) |
   | `custom.hyprpaper.enable` | `custom.hyprpaper.config` |
   | `custom.waybar.enable` | `custom.waybar.config` and `custom.waybar.style` |

   These take file contents, usually `builtins.readFile ./file` next to the host.
4. Register the host in `hosts/default.nix`.
5. `git add hosts/<name>`.

## 4. Secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix) and age. The encrypted file is `secrets/secrets.yaml`, and `.sops.yaml` lists which age public keys may decrypt it. Each host has its own age key.

> The sops module is currently required: the `mateus` user's password comes from sops, so `custom.sops.enable = false` will not evaluate as-is.

### 4.1 Generate the host's age key

On the machine being installed:

```sh
mkdir -p /mnt/var/lib/sops/age
nix shell nixpkgs#age -c age-keygen -o /mnt/var/lib/sops/age/keys.txt
chmod 600 /mnt/var/lib/sops/age/keys.txt
```

`age-keygen` prints the public key (`age1...`). You can print it again with `age-keygen -y /mnt/var/lib/sops/age/keys.txt`.

Back this file up somewhere safe. If you lose it, the secrets for that host cannot be decrypted.

### 4.2 Authorise the key

Add the public key to `.sops.yaml`, under `keys` and in the `creation_rules` group, then re-encrypt the file. This step needs a key that can already decrypt the file, so do it from a machine that is already set up (or, for a brand-new repository, create your own `secrets.yaml` instead, see "Adapting this configuration").

```sh
sops updatekeys secrets/secrets.yaml
```

### 4.3 Required secrets

Edit with `sops secrets/secrets.yaml`. The expected shape is:

```yaml
<hostname>:
    user-password: <hashed password>
wifi-env: |
    WIFI_HOME_PSK=...
    WIFI_PHONE_PSK=...
```

- `<hostname>/user-password` is the hashed login password for the main user (`hashedPasswordFile`, with `mutableUsers = false`). Generate it with:

  ```sh
  nix shell nixpkgs#mkpasswd -c mkpasswd -m yescrypt
  ```

- `wifi-env` is an environment file that provides the PSKs referenced by the profiles in `system/networking/wifi.nix`. It is only needed if `custom.wifi.enable = true`.

## 5. Root fallback password (optional)

Root is **locked** by default, so nothing secret is stored in the repository. If you want an emergency root login (useful because `systemd-boot`'s editor is disabled, so there is no `init=/bin/sh`), set a path in the host:

```nix
custom.rootPasswordFile = "/var/lib/secrets/root";
```

and create the file before the first boot. Use a different, strong password from your user password, and keep it out of sops on purpose, so a sops failure cannot lock you out of both accounts:

```sh
mkdir -p /mnt/var/lib/secrets
nix shell nixpkgs#mkpasswd -c mkpasswd -m yescrypt > /mnt/var/lib/secrets/root
chmod 600 /mnt/var/lib/secrets/root
```

SSH root login is disabled in `system/ssh`, so this password is only usable at the console or through `su`.

## 6. Install

```sh
nixos-install --flake .#<hostname>
```

`nixos-install` asks for a root password at the end. It is irrelevant here because users are managed declaratively (`mutableUsers = false`); set the one from step 5 instead if you want a fallback.

Reboot into the new system.

## 7. After the first boot

1. Log in with the password you stored in sops. The default session is chosen by `custom.desktop.defaultDE`.
2. Move the repository to `~/repos/nixos` if it is not there already, so the fish aliases work:

   ```sh
   rebuild-system   # sudo nixos-rebuild switch --flake ~/repos/nixos
   check-system     # dry-activate
   test-system      # test
   ```

   The aliases pass no `#<host>`, so Nix picks the configuration matching the machine's hostname.
3. Create or restore `~/.ssh/id_ed25519`. It is used for GitHub access and for signing commits (`gpg.format = "ssh"`, `commit.gpgsign = true`), so commits fail until it exists.
4. Join Tailscale if you use it: `sudo tailscale up`.
5. Flatpak apps are declared in the config and unmanaged ones are removed (`uninstallUnmanaged = true`), so install new Flatpak apps by adding them to `user/flatpak.nix` instead of installing them by hand.
6. If `/mnt/pocket` is not present on your machine, remove or change it in `system/file-system/default.nix`; it is mounted by label with `nofail`.

## Adapting this configuration

This repository is built around my own setup. If you use it as a base, change these before your first build:

| What | Where |
| --- | --- |
| Usernames and groups | `system/users/default.nix` |
| SSH `AllowUsers` and the Tailscale service | `system/ssh/default.nix` |
| WiFi networks, SSIDs and identities | `system/networking/wifi.nix` |
| Git name, email and signing key | `user/git/default.nix` |
| Locale, timezone and keymap | `system/locale`, `system/console`, `hosts/<name>` |
| Mounted data disk | `system/file-system/default.nix` |
| Hardcoded repository path in fish aliases | `user/fish/default.nix` |
| Laptop power-management device addresses | `system/profiles/laptop.nix` (they are specific to my hardware) |
| sops recipients and `secrets/secrets.yaml` | `.sops.yaml`, `secrets/` |

You cannot decrypt my `secrets/secrets.yaml`. Replace it with your own: delete the file, update `.sops.yaml` with your age public key, then create a new one with `sops secrets/secrets.yaml` containing the entries from step 4.3.

## Development helpers

Generate the Hyprland Lua type stubs used by the language server:

```sh
nix run .#hyprstubs
```

Format the Nix files with `nix fmt`.
