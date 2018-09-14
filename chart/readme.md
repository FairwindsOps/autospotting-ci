# Autospotting Helm Chart


## Chart Details
This chart will do the following:
* Implement autospotting, a tool to automatically convert your existing autoscaling groups to cheaper spot instances with minimal config chanages.  The source code for autospotting is available at [cristim/autospotting](https://github.com/cristim/autospotting).

## Configuration
| Parameter               | Description                           | Default                                                    |
| ----------------------- | ----------------------------------    | ---------------------------------------------------------- |
| `image`                 | uri to pull the image from            | `308882746353.dkr.ecr.us-east-1.amazonaws.com/parkassist/autospotting-ci:latest` |
| `schedule`              | cron schedule the job will run with   | `*/5 * * * *`                                              |
| `resources.cpu`         | cpu millicores to request             | `30m`                                                    |
| `resources.mem`         | amount of physical mem to request     | `30Mi`|
| `regions`               | comma separated list of regions where it should be activated.  Set to empty string to run in all regions. | `us-east-1` |
| `allowed_instance_types` | comma separated string of allowed instance types.  Set to empty string to allow all instance types. | `r4.*` |
