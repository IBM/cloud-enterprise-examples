data "local_file" "app" {
  filename = "${path.module}/app/app.py"
}

data "local_file" "import" {
  filename = "${path.module}/app/import.py"
}

data "local_file" "requirements" {
  filename = "${path.module}/app/requirements.txt"
}

data "local_file" "db" {
  filename = "${path.module}/app/db.min.json"
}
