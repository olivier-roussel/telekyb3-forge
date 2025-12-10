# Telekyb3-forge

## About
Conda packages custom forge for telekyb3 framework.

Contains recipes to build Conda packages for software of telekyb3 and workflows to generate these packages on GitHub runners.
Telekyb3 Conda packages are hosted on Prefix.dev public channel: https://prefix.dev/channels/telekyb-forge .

## How to use these packages

### Using Conda

Example: install genom3 package
```
conda install -c https://prefix.dev/telekyb-forge genom3
```

## How to add new packages to the forge

### Prerequisites

- A Conda installation ([miniforge](https://github.com/conda-forge/miniforge) recommanded)
- A Conda environment with the following packages installed:
  - [conda-smithy](https://github.com/conda-forge/conda-smithy) : To generate recipe configuration files, mandatory
  - [rattler-build](https://github.com/prefix-dev/rattler-build) : Tool for building conda packages, highly recommanded to test recipes building locally

Example of adding support for software `foo`:

1. Create a new directory for your software `foo` under `conda/recipes`
2. Create a sub-directory `recipe` in `conda/recipes` and a file `recipe.yaml` in this sub-directory which will define
   the recipe of the conda package. The conda recipe `recipe.yaml` file should be in v1 format specifications, i.e. following `rattler-build` [recipe specifications](https://rattler-build.prefix.dev/latest/reference/recipe_file/).
3. Create the configuration files using `conda-smithy`
   - Run from project root directory:
   ```
   conda smithy rerender --feedstock_config conda/configs/conda-build.yaml --feedstock_directory conda/recipes/foo
   ```
   - Unstage all changes that `conda-smithy` has made to `git`. As we are making a unintended usage of `conda-smithy` which automatically stage its change to git, we do not want to commit all this and it is recommanded you unstage everything:
   ```
   git reset
   ```
   - `conda-smithy` should have added a lot of files/folders into your recipe folder `conda/recipes/foo`. You must remove everything it added excepted the directory `conda/recipes/foo/.ci_support/`, which contains the files we need.
   - You must also remove unwanted platforms files from `conda/recipes/foo/.ci_support/` (e.g. `win_64_.yaml` if you don't need Windows support) and the `README.txt` file. To avoid that these unwanted files/platforms to be re-added by the future automatic re-rendering PRs, you must add a `.gitignore` file inside the directory `conda/recipes/foo/.ci_support/` which will contain the `README` file and un-wanted platforms if any (e.g. `win_64_.yaml`).
   - Filter all remaining configurations Yaml files in `conda/recipes/foo/.ci_support/` by:
     ```
     python scripts/filter_configs.py scripts/filter.yaml conda/recipes/foo/.ci_support/*.yaml
     ```
4. Update the GitHub actions workflows for building `foo` Conda package
   TODO
6. Update the GitHub actions workflows for re-rendering `foo` Conda package
   TODO
   
