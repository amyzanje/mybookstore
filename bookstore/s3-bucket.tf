resource "aws_s3_bucket" "S3Bucket" {
  bucket = var.AssetsBucket
  force_destroy = true
}

resource "aws_s3_bucket" "S3Bucket2" {
  force_destroy = true
  bucket = var.pipelinebucket
}

resource "aws_s3_bucket_policy" "S3BucketPolicy" {
  bucket = aws_s3_bucket.S3Bucket.id
  #policy = "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"aws_cloudfront_origin_access_identity.example.iam_arn\"},\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::${var.AssetsBucket}/*\"}]}"

  policy = <<EOF
    {
    "Version": "2008-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.CloudFrontCloudFrontOriginAccessIdentity.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.AssetsBucket}/*"
        }
    ]
}
EOF
}

