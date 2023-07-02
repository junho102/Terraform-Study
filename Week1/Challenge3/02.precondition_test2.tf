variable "file_name2" {
  default = "step0.txt"
}

variable "file_name_list" {
  type        = list(string)
  default     = ["step0.txt", "step1.txt", "step2.txt", "step3.txt", "step4.txt", "step5.txt", "step6.txt"]
}


resource "local_file" "def" {
  content  = "lifecycle-step 6"
  filename = "${path.module}/${var.file_name2}"

  lifecycle {
    precondition {
      condition      = contains(var.file_name_list, var.file_name2)
      error_message  = "file name is not step0.txt to step6.txt"
    }
  }
}