output "instance_profile_name" {
  description = "Name of the instance's profile (either built or supplied)"
  value       = aws_iam_instance_profile.default.name
}