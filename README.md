A Proof of Concept for scheduling a GitHub Action Workflow based on the output of the CarbonAwareSDK

# How it works

1. on a PR merge, the workflow 'delayCalculator.yml' runs

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

# Problems
1. Github hosted runners do not currnetly give their exact location. Github uses the following azure regions (https://github.com/orgs/community/discussions/24969):

    - East US (eastus)
    - East US 2 (eastus2)
    - West US 2 (westus2)
    - Central US (centralus)
    - South Central US (southcentralus)
   Should we take an average of all possible locations if using github hosted runners?

2. Need to host our own version? Not sure what this hosted version is for, only reference to it is that it was used for a 2022 hackathon so may be taken down at any minute

