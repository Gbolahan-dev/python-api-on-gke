terraform{
  backend "gcs" {
    bucket = "tf-state-dotted-aileron-471607-m2"
    prefix = "Python-GKE"
 }
}
