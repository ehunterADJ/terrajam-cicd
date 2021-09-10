terraform {
  backend "s3" {
    bucket = "jam-infra-state"
    region = "af-south-1"
    key    = "state"
  }
}
