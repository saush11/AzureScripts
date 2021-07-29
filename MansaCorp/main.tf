terraform {
  backend "remote" {
    organization = "MansaCorp"

    workspaces {
      name = "dummy-workspace"
    }
  }
}