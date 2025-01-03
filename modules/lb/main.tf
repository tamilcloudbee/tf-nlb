resource "aws_lb" "lb" {
  name               = "${var.resource_prefix}${var.load_balancer_type}-lb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  subnets            = var.public_subnet_ids

  tags = {
    Environment = var.env_name
    Name        = "${var.resource_prefix}${var.load_balancer_type}-lb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.resource_prefix}${var.load_balancer_type}-tg"
  port        = var.listener_port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.load_balancer_type == "network" ? "instance" : "ip"

  health_check {
    interval            = 30
    path                = var.protocol == "HTTP" || var.protocol == "HTTPS" ? "/" : null
    port                = "traffic-port"
    protocol            = var.protocol
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 3
  }

  tags = {
    Environment = var.env_name
    Name        = "${var.resource_prefix}${var.load_balancer_type}-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.listener_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}



resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each         = var.instance_ids
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = each.value
  port             = var.target_port
}


