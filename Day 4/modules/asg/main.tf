resource "aws_launch_template" "project-template_asg" {
    name = "multi-tier-template"
    image_id = var.ami
    instance_type = var.instance
    key_name=var.key_name
    user_data = filebase64("${path.module}/user_data.sh")

    vpc_security_group_ids = [var.client_sg_id]
    tags={
        name= "Multi-tier-template"
    }

}

resource "aws_autoscaling_group" "sk_asg" {
  name                      = "Multitier-project-test"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = [var.pri_sub_1_id, var.pri_sub_2_id]
  target_group_arns         = [var.tg_arn]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"
  
  launch_template {
    id      = aws_launch_template.project-template_asg.id
    version = aws_launch_template.project-template_asg.latest_version
  }
}

#Scale Up Policy
resource "aws_autoscaling_policy" "scale_up" {
    name= "project-template-asg-policy"
    autoscaling_group_name = aws_autoscaling_group.sk_asg.name
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    scaling_adjustment = 1
    policy_type = "SimpleScaling"

}

# scale up alarm
# alarm will trigger the ASG policy (scale up/down) based on the metric (CPUUtilization), comparison_operator, threshold
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
    alarm_name                = "Multitier_scaleUp_alarm"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 2
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 120
    statistic                 = "Average"
    threshold                 = 70 # New instance will be created once CPU utilization is higher than 30 %
    alarm_description         = "Auto Scaling Scale Up alarm when CPU exceeds 10%"
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.sk_asg.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.scale_up.arn]
}

#Scale Down Policy
resource "aws_autoscaling_policy" "scale_down" {
    name= "project-template-asg-policy"
    autoscaling_group_name = aws_autoscaling_group.sk_asg.name
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    scaling_adjustment = -1
    policy_type = "SimpleScaling"
}

# scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
    alarm_name                = "Multitier_scaleDown_alarm"
    comparison_operator       = "GreaterThanOrEqualToThreshold"
    evaluation_periods        = 2
    metric_name               = "CPUUtilization"
    namespace                 = "AWS/EC2"
    period                    = 120
    statistic                 = "Average"
    threshold                 = 10 # Instance will scale down when CPU utilization is lower than 10 %
    alarm_description         = "Auto Scaling Scale down alarm when CPU exceeds 10%"
    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.sk_asg.name
  }

  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.scale_down.arn]
}