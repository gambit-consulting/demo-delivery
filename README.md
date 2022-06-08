# demo-delivery - CAP

Welcome to the Gambit demo project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide

## Prerequisites

With the first steps below, you can go for a minimal local setup as follows:

1. [Install Node.js](https://nodejs.org/en/) → always use the latest LTS version.
2. [Install SQLite](https://sqlite.org/download.html) (only required on Windows).
3. Install `@sap/cds-dk` globally with:

    ```bash
    npm i -g @sap/cds-dk
    cds # test installation
    ```

## Run it yourself

- Open a new terminal
- Download the Repository with `git clone https://github.com/gambit-consulting/demo-delivery.git`
- Switch to the CAP part `git checkout cap`
- Download and install the required dependencies with `npm i`
- Run the App locally with `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)

## Learn More

Learn more at <https://cap.cloud.sap/docs/get-started/>.
