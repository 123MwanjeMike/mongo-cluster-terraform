### GCP Setup
1. Create a GCP project
    ```bash
    gcloud projects create --name=<PROJECT_NAME>
    ```
   Substitute `<PROJECT_NAME>` with a value of your choice. You will also need to record the `project ID` that is generated to substitute in steps 4 and 6.
2. Enable the required APIs
    ```bash
    gcloud services enable compute.googleapis.com dns.googleapis.com iam.googleapis.com
    ```
3. Create a service account and download the key file
    ```bash
    gcloud iam service-accounts create terraform-sa \
    --description="For use with Terraform" \
    --display-name="terraform-sa"
    ```
4. Create a JSON key for the service account
    ```bash
    gcloud iam service-accounts keys create gcp/terraform-sa-key.json \
    --iam-account=terraform-sa@<PROJECT_ID>.iam.gserviceaccount.com
    ```
5. Give the service account "Editor permissions"
6. Create and populate a `terraform.tfvars` file with the commands below:
    ```bash
    echo 'project_id = "<PROJECT_ID>"' > terraform.tfvars
    echo 'project_number = "<PROJECT_NAME>"' >> terraform.tfvars
    ```
