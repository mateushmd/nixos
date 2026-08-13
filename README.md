# My NixOS Configuration

An opinionated NixOS flake configuration that suits my exact workflow. Might offend some hardcore nixers, but life goes on.

It still requires a few imperative setup steps and is not fully customizable out of the box. See [INSTALL.md](./INSTALL.md) for a complete fresh-install walkthrough and guidance on adapting this configuration for your own setup.

## Roadmap

- [ ] Pretty desktop
- [ ] Wrap all user apps enforcing `XDG_CONFIG_HOME`
- [ ] Truly homeless system
- [ ] Impermanent system
- [ ] Better custom options for hosts
- [ ] Documentation
- [ ] Fully declarative/automated setup

## Structure

- `hosts/`: Per-host system configurations.
- `scripts/`: Simply wrapped utility scripts.
- `secrets/`: Encrypted SOPS secret files.
- `system/`: Theoretically immutable configuration across users.
- `user/`: Mutable configuration across users.
- `wrapped/`: Packages wrapped with Lassulus' wrappers.

## Apps

- `hyprstubs`: Generates Hyprland Lua stubs automatically.

## Highlights

- **No Home Manager**
- **Managed secrets with SOPS**
- **Wrapped packages with Lassulus' wrappers**
- **Custom options for quick system customization across hosts**
