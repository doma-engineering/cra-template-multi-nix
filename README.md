# CRA template for rapid and sustainable prototyping

This is an _unofficial_ [Create React App](https://github.com/facebook/create-react-app) TypeScript template, backed by Nix and allowing for multiple entry points.

This temlpate also allows you to develop [WDIO](https://webdriver.io/) tests with a resonably modern Google Chrome backend.

To use this template, add `--template multi-nix` when creating a new app.

For example:

```sh
npx create-react-app my-app --template multi-nix

# or

yarn create react-app my-app --template multi-nix
```

For more information, please refer to:

- [Getting Started](https://create-react-app.dev/docs/getting-started) – How to create a new app.
- [User Guide](https://create-react-app.dev) – How to develop apps bootstrapped with Create React App.

## Nix

In [Doma](https://github.com/doma-engineering), we bootstrap Nix on Ubuntu 20.04 LTS via a [semi-automatic bootstrap script](https://raw.githubusercontent.com/cognivore/nix-home/main/boostrap_home_manager.sh).

It makes sure that you get all the necessary things installed in your system:

 1. direnv
 2. Multiuser Nix with all the modern functionality:
    a. Nix command
    b. Nix flakes

Given you have Nix installed, the flake will bootstrap eveything you need to work with React projects, namely:

 1. Typescript
 2. NodeJS 17
 3. Node-GYP
 4. Serve

Now you can simply write `direnv allow` and get hacking! No `npx n install latest` shenanigans, no version management... You don't even need nodejs installed systemwide!

## TypeScript

TypeScript is de-facto way to implement NodeJS and in-browser solution, what else to say. Type your stuff tightly, don't use `any`, and you'll be happy.

## Multiple entry points

To debug sometimes we really don't want to mess with the whole ReactRouter stuff and develop components in hermetic isolation (which, arguably, is a way to go anyway). Thus, we provide a convenience `run.ts`, which will get entrypoint as an argument and will build an app with this entry point as the root component.

To illustrate it, we ship the template with `App.tsx` and an `EmptyEntrypoint.tsx`, so you can run the whole thing with:

```
./run.ts EmptyEntrypoint.tsx
```

and pop browser pointing to that component.

## Webdriver.io tests

**NB! WDIO will be installed automatically as devDependency the first time you run `wdio.sh`**.

We have a minimal set of tests demonstrating that wdio indeed works and a solution to run the thing with `docker compose`. You'll need to install docker onto your Ubuntu 20.04 LTS Linux the way you want. I personally use Windows docker engine and corresponding packages from within Ubuntu. It works by linking a binary distribution of Docker, patched to use the Windows backend (somehow) into WSL2 /usr/bin. I assume that for your linux the installation instructions are different. It would be nice to have these instructions here, because docker documentation is all over the place. If you want to contribute these instructions, I'll be honoured to accept your PR.

The idea of using docker compose is twofold:

 1. It packages non-hermetic Google Chrome container, which allows to run wdio properly.
 2. It prevents port polution by creating a docker netowrk to run tests against.

## Roadmap

In Doma, we use libsodium for cryptography, because it sucks the least of all the options and is very cross-platform.

To make use of it, however, we need [a lot of shims](https://github.com/doma-engineering/do-auth/blob/main/priv/ui/config-overrides.js).
These shims can only be pushed into CRA's webpack config without ejecting via [react-app-rewired](https://github.com/doma-engineering/do-auth/blob/ecabe5c36df3fe5552577edac6764f92217231f8/priv/ui/package.json#L27-L29).

This is another thing I'd be glad to see incorporated in this template, perhaps, with some bootstrapping script. PRs welcome!
