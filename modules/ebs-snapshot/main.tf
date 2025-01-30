resource "aws_backup_vault" "jenkins_backup_vault" {
  name = "jenkins_backup_vault"
}

resource "aws_backup_plan" "jenkins_backup_plan" {
  name = "jenkins_backup_plan"

  rule {
    rule_name         = "daily_backup"
    target_vault_name = aws_backup_vault.jenkins_backup_vault.name
    schedule          = "cron(0 5 * * ? *)" 

    lifecycle {
      delete_after = 7 
    }
  }
}

resource "aws_backup_selection" "jenkins_backup_selection" {
  iam_role_arn = aws_iam_role.jenkins_backup_role.arn
  name         = "jenkins_backup_selection"
  plan_id      = aws_backup_plan.jenkins_backup_plan.id

  resources = [
    var.volume_id
  ]
}

resource "aws_iam_role" "jenkins_backup_role" {
  name = "jenkins_backup_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_backup_policy_attachment" {
  role       = aws_iam_role.jenkins_backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
