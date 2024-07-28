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

# Create a new project with GitHub integration
template_git("MyNewProject", github = TRUE)

# Create a new project without GitHub integration
template_git("LocalProject", github = FALSE)
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
- The `papaja` package (for creating APA style manuscripts)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
