A Proof of Concept for scheduling a GitHub Action Workflow based on the output of the CarbonAwareSDK

# How it works

Prerequisites: create personal access token named WORKFLOW_TOKEN that has workflow write access.

1. on a PR merge, the workflow runs

    1. Sets correct permissions for bash script
    2. copy/overwrite the scheduledWorkflow_template.yml into the workflows/ folder
    3. call scheduleWorkflowUsingHostedCarbonAwareSDK.bash

        1. calls hosted version of CarbonAwareSDK 
        2. extract first optimal time to run 10 min job within next 24 hours in 'ukwest' region (can change these parameters, only using these for the PoC).
        3. output reformatted timestamp into correct format for 'cron' trigger of workflow
    
    4. take output and replace the templated schedule in the newly copied/overwritten scheduledWorkflow.yml workflow
    5. Commit this updated workflow
    6. scheduledWorkflow workflow is now scheduled to run at the time forecasted to have the lowest carbon intensity
    7. scheduledWorkflow.yml ends by deleting itself to prevent it running every year


# Notes:
    - You can still manually trigger using the the scheduledWorkflow workflow using   'workflow_dispatch:'

### See issues for required work