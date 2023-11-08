A Proof of Concept for scheduling a GitHub Action Workflow based on the output of the CarbonAwareSDK

How it works:


1. on a PR merge, the workflow 'delayCalculator.yml' runs

    1. Sets correct permissions for bash script
    2. copy/overwrite the scheduledPublish_template.yml into the workflows/ folder
    3. uses output of scheduleWorkflowUsingHostedCarbonAwareSDK.bash

        1. calls hosted version of CarbonAwareSDK 
        2. extract first optimal time to run 10 min job within next 24 hours in 'ukwest' region (can change these parameters).
        3. output reformated timestamp into correct format for 'cron' trigger of workflow
    
    4. take output and replace the templated schedule in the newly copied/overwritten scheduledPublish.yml workflow
    5. Commit this updated workflow.
    6. scheduledPublish workflow is now scheduled to run at the time forecasted to have the lowest carbon intensity

Notes:
    - You can still manually trigger using the the scheduledPublish workflow using   'workflow_dispatch:'

Things to look into:
    - Need to host our own version? Not sure what this hosted version is for, only reference to it is that it was used for a 2022 hackathon so may be taken down at any minute
    - It will trigger every year, look into removing the scheduled workflow after executing the scheduled workflow.

