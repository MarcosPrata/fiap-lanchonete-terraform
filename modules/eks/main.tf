resource "aws_iam_role" "cluster_role" {
  name = "${var.project_name}-${var.app_env}-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project_name}-${var.app_env}-eks-cluster"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = var.cluster_subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.cluster_policy_attachment]
}
