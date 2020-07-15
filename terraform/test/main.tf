provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "host_bucket" {
  bucket = "host-bucket-1337"

  tags = {
    Name        = "Bucket containing web app"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "host_bucket" {
    bucket = "${aws_s3_bucket.host_bucket.id}"
    policy = templatefile("policy/public_bucket.json.tpl", {
        bucket_arn = aws_s3_bucket.host_bucket.arn
    })
}

resource "aws_s3_bucket" "server_asset_bucket" {
  bucket = "server-asset-bucket-1337"

  tags = {
    Name        = "Bucket with server assets for web app"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "server_asset_bucket" {
    bucket = "${aws_s3_bucket.server_asset_bucket.id}"
    policy = templatefile("policy/public_bucket.json.tpl", {
        bucket_arn = aws_s3_bucket.server_asset_bucket.arn
    })
}
