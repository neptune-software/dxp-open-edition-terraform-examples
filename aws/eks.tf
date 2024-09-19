resource "aws_eks_cluster" "this" {
  name     = local.eks.name
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = [ for k,v in local.vpc.subnets: aws_subnet.this[k].id ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

data "aws_eks_cluster_auth" "ephemeral" {
  name = local.eks.name
}
