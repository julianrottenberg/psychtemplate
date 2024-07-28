# psychtemplate

`psychtemplate` is an R package that provides tools to create standardized project structures for psychology research, including options for GitHub integration.

## Installation

You can install the development version of psychtemplate from GitHub with:

```r
# install.packages("devtools")
devtools::install_github("julianrottenberg/psychtemplate")
```

## Usage

To create a new psychology research project:

```r
library(psychtemplate)

# Create a new project with GitHub integration (default: private repository, APA 6 template)
template_git("MyNewProject", github = TRUE)

# Create a new project without GitHub integration
template_git("LocalProject", github = FALSE)

# Create a new project with GitHub integration and APA 7 template
template_git("MyNewProjectAPA7", github = TRUE, apa7 = TRUE)

# Create a new project with GitHub integration and public repository
template_git("PublicProject", github = TRUE, public_repo = TRUE)

# Create a new project with GitHub integration, APA 7 template, and public repository
template_git("PublicAPA7Project", github = TRUE, apa7 = TRUE, public_repo = TRUE)

```

This will create a new project with the following structure:

- README.md
- DESCRIPTION
- manuscript.Rmd
- files/ (empty directory)
- testing/ (empty directory)

If `github = TRUE`, it will also initialize a Git repository, create a private GitHub repository, and push the initial project structure to GitHub.

## Requirements

- A GitHub account and personal access token (for GitHub integration)
- The [`papaja`](https://github.com/crsh/papaja/) package (for creating APA style manuscripts)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
