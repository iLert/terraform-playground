# Alert actions playground

The provided default example in `alert-action.tf` creates a sample user, an escalation policy and an alert source. Additionally, the alert source features three alert actions (email, webhook, GitHub), whereas GitHub additionally connects with a GitHub connector.

For further testing purposes, a deprecated resource automation rule and its new counterpart alert source with type automation rule is also being created in the script.

> Note that those alert actions are provided with example credentials and do not work properly.

## Setup

1. Create `terraform.tfvars` file in current directory and enter your ilert API key. Example:

   ```
   api_token = "your api key"
   ```

   > You can create an api key in your ilert account under `User icon -> Manage API keys -> > Add API key`

2. Open terminal and navigate to current directory

   ```sh
   $ cd alert-actions/
   ```

3. Initialize the ilert Terraform provider, by executing the following command:

   ```sh
   $ terraform init
   ```

## Create/Edit resources

1. Edit `alert-action.tf` to declare the resources that should be created/edited in ilert

2. (Optional) Execute `terraform plan` to preview changed made and locate possible errors beforehand`

   ```sh
   $ terraform plan
   ```

3. Run `terraform apply` to create or edit the resources

   ```sh
   $ terraform apply
   ```
