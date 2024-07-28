#' Create a psychology research project template
#'
#' This function creates a new psychology research project with a predefined structure,
#' including necessary files and folders. It can also initialize a Git repository
#' and push the project to GitHub.
#'
#' @param project_name The name of the project to create.
#' @param github Logical, whether to create a GitHub repository and push the project.
#' @export
#' @importFrom usethis create_project
#' @importFrom gh gh gh_token
#' @importFrom rmarkdown draft
template_git <- function(project_name, github = TRUE) {
  message("Starting project creation for: ", project_name)

  original_dir <- getwd()
  project_path <- file.path(original_dir, project_name)
  usethis::create_project(project_path, open = FALSE)
  setwd(project_path)
  message("Created project at: ", project_path)

  dir.create(file.path(project_path, "files"))
  dir.create(file.path(project_path, "testing"))
  message("Created 'files' and 'testing' directories")

  create_readme(project_name)
  create_description(project_name)

  rmarkdown::draft("manuscript.Rmd", template = "apa6", package = "papaja", edit = FALSE)
  message("Created manuscript.Rmd")

  if (github) {
    tryCatch({
      create_github_repo(project_name)
      message("Successfully pushed project to GitHub")
    }, error = function(e) {
      message("An error occurred: ", e$message)
      message("Git status: ", paste(system("git status", intern = TRUE), collapse = "\n"))
    })
  }

  setwd(original_dir)
  message("Changed back to original directory: ", getwd())
  message("Project setup complete at ", project_path)
}

#' Add .gitkeep to empty directories
#'
#' @param dir_path The path to the directory to check for empty subdirectories.
#' @keywords internal
add_gitkeep_to_empty_dirs <- function(dir_path) {
  dirs <- list.dirs(dir_path, recursive = TRUE, full.names = TRUE)
  for (d in dirs) {
    if (length(list.files(d)) == 0) {
      file.create(file.path(d, ".gitkeep"))
      message("Added .gitkeep to empty directory: ", d)
    }
  }
}

#' Create README.md file
#'
#' @param project_name The name of the project.
#' @keywords internal
create_readme <- function(project_name) {
  readme_content <- paste("#", project_name, "\n\nThis is a psychological research project created with a custom R template.\n")
  writeLines(readme_content, "README.md")
  message("Created README.md")
}

#' Create DESCRIPTION file
#'
#' @param project_name The name of the project.
#' @keywords internal
create_description <- function(project_name) {
  description_content <- paste(
    "Package:", project_name, "\n",
    "Title: Psychological Research Project\n",
    "Version: 0.0.0.9000\n",
    "Description: This project uses the papaja package for APA style manuscripts.\n",
    "Imports: papaja\n"
  )
  writeLines(description_content, "DESCRIPTION")
  message("Created simple DESCRIPTION file")
}

#' Create GitHub repository and push the project
#'
#' @param project_name The name of the project.
#' @keywords internal
create_github_repo <- function(project_name) {
  token <- gh::gh_token()
  if (token == "") {
    stop("GitHub token not found. Please set up GitHub authentication.")
  }

  user <- gh::gh("/user")
  username <- user$login

  repo <- gh::gh("POST /user/repos", name = project_name, private = TRUE, auto_init = FALSE)
  repo_url <- repo$html_url
  message("Created empty GitHub repository: ", repo_url)

  system("git init")
  add_gitkeep_to_empty_dirs(".")

  remote_url <- paste0("https://", username, ":", token, "@github.com/", username, "/", project_name, ".git")
  system(paste0("git remote add origin '", remote_url, "'"))

  system("git add .")
  system('git commit -m "Initial commit: Project structure"')
  system("git branch -M main")

  push_result <- system("git push -u origin main", intern = TRUE)
  message("Push result: ", paste(push_result, collapse = "\n"))

  utils::browseURL(repo_url)
}
