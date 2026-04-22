##Overview
This project implements a self-healing monitoring system for a web application using basic DevOps tools. It continuously checks the health of a website and automatically takes corrective actions when failures are detected.

The system ensures that:
Users are shown a friendly maintenance page instead of raw errors
The web server is automatically restarted
The application recovers without manual intervention

##Problem Statement
In real-world systems, websites may become unavailable due to:
Server crashes
Service failures (e.g., Nginx stopping)
Configuration or runtime issues
This leads to:
Poor user experience (timeouts, blank pages)
Increased system load due to repeated retries
Manual intervention delays

##Solution
This project converts an uncontrolled failure into a controlled recovery process by:
Monitoring website health continuously
Tracking repeated failures
Switching to a maintenance page
Restarting the web server automatically
Restoring the normal website once recovered

##Target Users
This project is ideal for:
DevOps beginners and students
Small teams or startups
Personal projects hosted on Linux servers
Learning automation and system reliability concepts

##Flow Summary
1.Check website health using HTTP request
2.If healthy → reset failure count
3.If unhealthy → increment failure count
4.If failures exceed threshold:
5.Switch to maintenance mode
6.Restart Nginx
7.Once recovered → restore normal website

##Tech Stack
AWS EC2 (Ubuntu)
Nginx
Bash Scripting
GitHub

##Project Structure
self-healing-maintenance-system/
│
├── monitor.sh              # Core monitoring logic
├── run-monitor.sh          # Continuous execution script
│
├── site/
│   ├── index.html          # Normal website page
│   └── maintenance.html    # Maintenance page
│
├── state/
│   ├── mode.txt            # Current mode (normal/maintenance)
│   ├── fail_count.txt      # Failure counter
│   ├── restart_count.txt   # Restart counter
│   └── monitor.log         # Logs

##Key Idea
This is a beginner-friendly DevOps project that demonstrates:
monitoring → failure detection → automatic recovery

⚠️#Note
This is an educational prototype, not a replacement for enterprise tools like Kubernetes or cloud monitoring systems.
