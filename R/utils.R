#' Parse the `shiny_input` value from JSON
#'
#' @param val value to get from JSON
#'
#' @return Value of type defined in `shiny_input`
parse_val <- function(val) {
  jsonlite::fromJSON(ifelse(is.null(val), '""', val))
}

#' Check if color is set from Fomantic-UI palette
#'
#' @param color character with color name
#'
#' @return Error when \code{color} does not belong to palette
#' @export
#' @examples
#' check_proper_color("blue")
check_proper_color <- function(color) {
  if (!(color %in% c("", names(COLOR_PALETTE)))) {
    stop("Wrong color parameter specified!")
  } else {
    invisible(color)
  }
}

#' Checks whether argument included as shiny exclusive parameter
#'
#' @description
#' A quick function to check a shiny.semantic wrapper of a shiny function to see whether any
#' extra arguments are called that aren't required for the shiny.semantic version
#'
#' @param name Function argument name
#' @param func Name of the function in the
#' @param ... Arguments passed to the shiny.semantic version of the shiny function
#'
#' @return If the shiny exclusive argument is called in a shiny.semantic, then a message is posted in the UI
check_shiny_param <- function(name, func, ...) {
  args <- list(...)
  args_names <- names(args)

  if (name %in% args_names) message("'", name, "' is a shiny::", func, " specific parameter")
}

#' ::: hack solution to pass CRAN checks
#'
#' @param pkg package name
#' @param name function name
#'
#' @return function
`%:::%` <- function(pkg, name) { # nolint
  pkg <- as.character(substitute(pkg))
  name <- as.character(substitute(name))
  get(name, envir = asNamespace(pkg), inherits = FALSE)
}

#' Some elements require input id, but this does not need to be
#' specified by the user. Thus we assign random value with prefix where needed.
#'
#' @param prefix character with prefix add to id
#' @param id_length numeric with length of id (default 20)
generate_random_id <- function(prefix, id_length = 20) {
  random_id <- paste(sample(letters, id_length, replace = TRUE), collapse = "")
  paste0(prefix, "-", random_id)
}

#' Check for extra arguments
#'
#' This throws warning if there are parameters not supported by semantic.
#'
#' @param args list with extra arguments
check_extra_arguments <- function(args) {
  to_wrn <- paste0(as.character(names(args)), collapse = ',')
if (nchar(to_wrn) > 1)
  warning(glue::glue("arguments: `{to_wrn}` not supported yet in semantic version"))
}

#' Extract icon name
#'
#' @param icon icon object
#'
#' @return character with icon name
extract_icon_name <- function(icon) {
  gsub(" icon", "", icon$attribs$class)
}

#' Split arguments to positional and named
#'
#' @param ... arguments to split
#'
#' @return
#' A list with two named elements:
#' * `positional`, a list of the positional arguments,
#' * `named`, a list of the named arguments.
#'
#' @md
split_args <- function(...) {
  args <- list(...)
  if (is.null(names(args))) {
    is_named <- logical(length(args))
  } else {
    is_named <- nzchar(names(args))
  }
  return(list(positional = args[!is_named], named = args[is_named]))
}
