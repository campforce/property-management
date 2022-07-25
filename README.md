[![release](https://github.com/campforce/property-management/actions/workflows/release.yml/badge.svg)](https://github.com/campforce/property-management/actions/workflows/release.yml)
[![validation](https://github.com/campforce/property-management/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/campforce/property-management/actions/workflows/validate.yml)

# Property Management App

## Requirements
  - Enable Dev Hub in your Org
  - Install Salesforce CLI
  - Install Visual Studio Code
  - Install the Visual Studio Code Salesforce extensions

## Installation

1. Clone this repository:

    ```
    git clone https://github.com/campforce/property-management.git
    cd property-management
    ```

1. Authorize your hub org:

    ```
    sfdx auth:web:login -d -a devhub
    ```

1. Create a scratch org:

    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a app
    ```

1. Push the app to your scratch org:

    ```
    sfdx force:source:push
    ```

1. Assign the **superuser** permission set to enable super feaures:

    ```
    sfdx force:user:permset:assign -n superuser
    ```

1. Open the scratch org:

    ```
    sfdx force:org:open
    ```
## Good luck 🙂
<p align="center"><img src="https://user-images.githubusercontent.com/89274213/180623779-80d90bb4-c850-46c6-ab99-6a10c031e74e.gif"/></p>


## Contributors
<a href = "https://github.com/campforce/property-management/graphs/contributors">
  <img src = "https://contrib.rocks/image?repo=campforce/property-management"/>
</a>

