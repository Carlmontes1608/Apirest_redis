variable "selectami" {}

variable "image" {
    type = map
    default = {
        ami2 = "ami-090fa75af13c156b4"
        redhat = "ami-06178cf087598769c"
        ubuntu = "ami-037211dc049411d37"
        windows = "ami-0ae15c1544cd06ac8" 
    }
}

variable "instancetype" {
    type = string
    default = "t2.micro"
}
