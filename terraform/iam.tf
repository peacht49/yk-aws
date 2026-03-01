# Create user
/*
resource "aws_iam_user" "s3_manager" {
  name = "s3-manager-user"
  tags = {
    Description = "User for manual S3 management"
  }
}

# To tell terraform of an existing user, use data source

data "aws_iam_user" "s3_manager" {
  user_name = "ywong74"
}


# Attach a custom policy

resource "aws_iam_user_policy" "custom_bucket_access" {
  name = "limit-to-my-bucket"
  user = data.aws_iam_user.s3_manager.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
})
}
*/
