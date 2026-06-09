resource "aws_ebs_snapshot_block_public_access" "region" {
  state = "block-all-sharing"
}
