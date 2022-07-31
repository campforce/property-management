[![release](https://github.com/campforce/property-management/actions/workflows/release.yml/badge.svg)](https://github.com/campforce/property-management/actions/workflows/release.yml)
[![validation](https://github.com/campforce/property-management/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/campforce/property-management/actions/workflows/validate.yml)
[![codecov](https://codecov.io/gh/campforce/property-management/branch/main/graph/badge.svg?token=MACRKT47PM)](https://codecov.io/gh/campforce/property-management)

# Property Management App

<img width="1512" alt="demo" src="https://user-images.githubusercontent.com/89274213/181918458-fa7b0970-27e2-4950-893f-579a7fcf7410.png">

## Installation

### Requirements
  - Enable Dev Hub in your Org
  - Install Salesforce CLI
  - Install Visual Studio Code
  - Install the Visual Studio Code Salesforce extensions

---

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

## Repo Structure
```
/
├─ .github/workflows              # Github actions scripts
├─ config/                        # Scratch org configuration
├─ docs/                          # Web-to-Lead form for github page
├─ force-app/
│  ├─ main/default/       
│  │  ├─ applications/  
│  │  ├─ aura/  
│  │  ├─ classes/                 # Apex classes
│  │  │  ├─ architecture/         # Trigger framework
│  │  │  │  └─ triggerhandlers/   # Trigger handlers
│  │  │  ├─ batchables/           # Batchable and Schedulable
│  │  │  ├─ controllers/          # Controllers
│  │  │  └─ services/             # Service layer
│  │  │  
│  │  ├─ contentassets/  
│  │  ├─ email/unfiled$public/    # Email templates
│  │  ├─ flexipages/
│  │  ├─ layouts/
│  │  ├─ lwc/                     # Lightning web components
│  │  │  ├─ libsChartjs/          # Chart property types
│  │  │  └─ map/                  # Google map
│  │  ├─ objects/
│  │  ├─ permissionsets/
│  │  ├─ profiles/
│  │  ├─ remotesitesettings/
│  │  ├─ settings/
│  │  ├─ staticresources/
│  │  ├─ tabs/
│  │  └─ triggers/                # Triggers
│  └─ test/default/classes/       # Unit tests
│
├─ mainfiest/                     # Metadata to retrieve or deploy
├─ .forceignore                   # Untracked files for source control
├─ .gitignore                     # Untracked files for version control
├─ README.md                      # This file
├─ jest.config.js            
├─ package.json              
└─ sfdx-project.json         
```

## Contributors
<a href = "https://github.com/campforce/property-management/graphs/contributors">
  <img src = "https://contrib.rocks/image?repo=campforce/property-management"/>
</a>

